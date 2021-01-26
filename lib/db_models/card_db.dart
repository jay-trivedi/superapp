import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_app/models/card_details.dart';
import 'package:super_app/models/sms_message.dart';

class CARDDB {
  Future<Database> getCARDDB() async {
    print("Accessing the Cards DB");
    return openDatabase(
        join(
          await getDatabasesPath(),
          'superapp_db.db',
        ),
        version: 3, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE cards_table (cardSNo INTEGER AUTOINCREMENT, cardUid TEXT PRIMARY KEY, cardNo TEXT, bankName TEXT);");
    });
  }

  Future<int> insertCard(CardDetails card) async {
    final Database db = await getCARDDB();
    print("Inserting to db ${card.cardUid}");
    int temp = await isCardPresent(card);
    if (temp == -1) {
      return await db.insert(
        'cards_table',
        card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      return temp;
    }
  }

  Future<int> isCardPresent(CardDetails card) async {
    final Database db = await getCARDDB();
    var result = await db
        .query('cards_table', where: 'cardUid = ?', whereArgs: [card.cardUid]);
    if (result.length == 0) {
      return -1;
    } else {
      return result[0]['cardSNo'];
    }
  }

  Future<List<CardDetails>> getAllCardsDB() async {
    final Database db = await getCARDDB();
    final List<Map<String, dynamic>> maps = await db.query('cards_table');
    // print(maps);
    return List.generate(
      maps.length,
      (index) => CardDetails(
        cardSNo: maps[index]['cardSNo'],
        cardUid: maps[index]['cardUid'],
        cardNo: maps[index]['cardNo'],
        bankName: maps[index]['bankName'],
      ),
    );
  }

  Future<void> updateCard(CardDetails card) async {
    final Database db = await getCARDDB();
    print("Updating Card Amount ${card.cardUid}");
    await db.update(
      'cards_table',
      card.toMap(),
      where: "cardUid = ?",
      whereArgs: [card.cardUid],
    );
  }
}
