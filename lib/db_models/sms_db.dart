import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_app/models/card_details.dart';
import 'package:super_app/models/sms_message.dart';

class SMSDB {
  Future<Database> getSMSDB() async {
    print("Accessing DB");
    return openDatabase(
        join(
          await getDatabasesPath(),
          'superapp_db.db',
        ),
        version: 3, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE sms_table (smsId INTEGER PRIMARY KEY AUTOINCREMENT, vendor TEXT, amountCredited REAL, cardNo TEXT, availableBalance REAL, transactionDate INTEGER, description TEXT, cardId INTEGER, bankName TEXT)");
      db.execute(
          "CREATE TABLE cards_table (cardSNo INTEGER PRIMARY KEY, cardUid TEXT, cardNo TEXT, bankName TEXT, amountSpent REAL)");
    });
    //FOREIGN KEY(cardId) REFERENCES cards_table(cardSNo);
  }

  Future<List<dynamic>> insertSMS(BankSMSMessage message) async {
    final Database db = await getSMSDB();
    print("Inserting to db ${message.amountCredited}");
    BankSMSMessage foundMessage = await isMessagePresent(message);
    if (foundMessage == null) {
      var id = await db.insert(
        'sms_table',
        message.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return [id, null];
    }
    return [foundMessage.smsId, foundMessage.description];
  }

  Future<void> updateSMS(BankSMSMessage message) async {
    final Database db = await getSMSDB();
    print("Updatinggg %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    print(message.smsId);
    print("%%%%%%%%%%%%%%%%%");
    print(await db.update(
      'sms_table',
      message.toMap(),
      where: "smsId = ?",
      whereArgs: [message.smsId],
    ));
  }

  Future<void> deleteSMS(DateTime date) async {
    final Database db = await getSMSDB();
    print(date);
    print("Deleting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    print(await db.delete(
      'sms_table',
      where: "transactionDate >= ?",
      whereArgs: [date.millisecondsSinceEpoch],
    ));
  }

  Future<BankSMSMessage> isMessagePresent(BankSMSMessage message) async {
    final Database db = await getSMSDB();
    String query = 'SELECT * FROM sms_table WHERE cardNo="' +
        message.cardNo +
        '" AND vendor="' +
        message.vendor +
        '" AND transactionDate=' +
        message.transactionDate.millisecondsSinceEpoch.toString() +
        ' AND bankName="' +
        message.bankName +
        '" AND amountCredited="' +
        message.amountCredited.toString() +
        '";';
    final result = await db.rawQuery(query);
    if (result.length == 0) {
      return null;
    } else {
      print("Already Exists");
      var bankName = result[0]['bankName'];
      var cardNo = result[0]['cardNo'];
      var card = (await db.query('cards_table',
          where: 'cardUid = ?', whereArgs: ["${cardNo}_$bankName"]))[0];
      return BankSMSMessage(
        smsId: result[0]['smsId'],
        vendor: result[0]['vendor'],
        amountCredited: result[0]['amountCredited'],
        cardNo: result[0]['cardNo'],
        availableBalance: result[0]['availableBalance'],
        bankName: result[0]['bankName'],
        transactionDate:
            DateTime.fromMillisecondsSinceEpoch(result[0]['transactionDate']),
        info: CardDetails(
            bankName: card['bankName'],
            cardUid: card['cardUid'],
            cardSNo: card['cardSNo'],
            cardNo: card['cardNo'],
            amountSpent: card['amountSpent']),
        description:
            result[0]['description'] == null ? "" : result[0]['description'],
      );
    }
  }

  Future<int> getLatestDate() async {
    final Database db = await getSMSDB();
    final List<Map<String, dynamic>> maps =
        await db.query('sms_table', orderBy: "transactionDate DESC");
    if (maps.length == 0) {
      return 0;
    } else {
      return maps[0]['transactionDate'];
    }
  }

  Future<List<BankSMSMessage>> getAllMessagesDB(bool needLatest) async {
    final Database db = await getSMSDB();
    print('Came back');
    int date;
    if (needLatest) {
      date = await this.getLatestDate();
    } else {
      date = DateTime.now().subtract(Duration(days: 90)).millisecondsSinceEpoch;
    }

    final query =
        "SELECT * FROM sms_table WHERE transactionDate>=" + date.toString();
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    // final List<Map<String, dynamic>> maps =
    //     await db.query('sms_table', orderBy: "transactionDate DESC");
    final List<Map<String, dynamic>> cardsMap =
        await db.query('cards_table', orderBy: "cardSNo");
    print(maps);
    // print(cardsMap);

    List<BankSMSMessage> newList;
    newList = List.generate(
      maps.length,
      (index) {
        int temp = 0;
        for (int i = 0; i < cardsMap.length; i++) {
          if (cardsMap[i]['cardSNo'] == maps[index]['cardId']) temp = i;
        }
        return BankSMSMessage(
          smsId: maps[index]['smsId'],
          vendor: maps[index]['vendor'],
          amountCredited: maps[index]['amountCredited'],
          cardNo: maps[index]['cardNo'],
          availableBalance: maps[index]['availableBalance'],
          bankName: maps[index]['bankName'],
          transactionDate: DateTime.fromMillisecondsSinceEpoch(
              maps[index]['transactionDate']),
          // info: maps[index]['cardId'],
          info: CardDetails(
              bankName: cardsMap[temp]['bankName'],
              cardUid: cardsMap[temp]['cardUid'],
              cardSNo: cardsMap[temp]['cardSNo'],
              cardNo: cardsMap[temp]['cardNo'],
              amountSpent: cardsMap[temp]['amountSpent']),
          description: maps[index]['description'] == null
              ? ""
              : maps[index]['description'],
        );
      },
    );
    return newList;
  }
}
