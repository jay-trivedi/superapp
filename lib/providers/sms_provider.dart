import 'package:flutter/foundation.dart';
import 'package:sms/sms.dart';
import 'package:super_app/db_models/sms_db.dart';
import 'package:super_app/models/sms_message.dart';
import 'package:super_app/models/sms_parser.dart';
import 'package:super_app/providers/cards_provider.dart';
import 'package:super_app/db_models/card_db.dart';
import 'package:super_app/providers/error_provider.dart';

class SMSProvider extends ChangeNotifier {
  List<BankSMSMessage> _messages = [];
  int _filterCard;
  SMSDB smsdb = new SMSDB();
  CARDDB carddb = new CARDDB();

  List<BankSMSMessage> get messages {
    if (_filterCard == null) {
      return [..._messages];
    } else {
      List<BankSMSMessage> filteredMessages = [];
      _messages.forEach((element) {
        if (element.info.cardSNo == _filterCard) {
          filteredMessages.add(element);
        }
      });
      return filteredMessages;
    }
  }

  void filterSMS(int cardSNo) {
    _filterCard = cardSNo;
    print('********');
    print(_filterCard);
    notifyListeners();
  }

  Future<void> fetchMessages(
      CardsProvider cardsProvider, ErrorProvider errorProvider) async {
    SmsQuery query = new SmsQuery();
    DateTime latestDate;
    // Getting messages from the DB
    _messages = await smsdb.getAllMessagesDB(false);
    if (_messages.length != 0) {
      notifyListeners();
      latestDate = _messages[0].transactionDate.subtract(Duration(days: 1));
      // await smsdb.deleteSMS(latestDate.add(Duration(days: 1)));
    } else {
      int temp = await smsdb.getLatestDate();
      if (temp != 0) {
        latestDate = DateTime.fromMillisecondsSinceEpoch(temp)
            .subtract(Duration(days: 1));
        // await smsdb.deleteSMS(latestDate.add(Duration(days: 1)));
      }
    }
    //Getting all the SMS and parsing
    List<SmsMessage> allMessages = new List();
    allMessages = await query.getAllSms;
    print(latestDate);
    _messages
        .removeWhere((element) => element.transactionDate.isAfter(latestDate));
    SMSParser smsParser = SMSParser(cardsProvider, latestDate, errorProvider);
    print('##############');
    print(latestDate);
    print("##################");
    print(_messages);
    List<BankSMSMessage> obtainedMessages =
        await smsParser.messageParser(allMessages, [..._messages]);
    obtainedMessages.addAll(_messages);
    _messages = obtainedMessages;
    if (_messages.length == 0) {
      var temp = await smsdb.getAllMessagesDB(true);
      _messages = temp;
    }
    cardsProvider.fetchCards(this);
    notifyListeners();
    return;
  }

  double getTotal(String bankName, String cardNo) {
    double totalAmount = 0.0;
    var today = DateTime.now();
    _messages.forEach((element) {
      if (element.bankName == bankName && element.cardNo == cardNo && element.transactionDate.isAfter(new DateTime(today.year,today.month))) {
        totalAmount += element.amountCredited;
      }
    });
    return totalAmount;
  }

  void editMessageDescription(int index, String descp) {
    _messages[index].editDescription(descp);
    smsdb.updateSMS(_messages[index]);
    notifyListeners();
  }
}
