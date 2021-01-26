import 'package:sms/sms.dart';
import 'package:super_app/db_models/sms_db.dart';
import 'package:super_app/models/error_message.dart';
import 'package:super_app/models/sms_message.dart';
import 'package:super_app/providers/cards_provider.dart';
import 'package:super_app/db_models/card_db.dart';
import 'package:super_app/providers/error_provider.dart';

class SMSParser {
  CardsProvider cardsProvider;
  DateTime latestDate;
  ErrorProvider errorProvider;
  SMSParser(
    this.cardsProvider,
    this.latestDate,
    this.errorProvider,
  );

  Future<List<BankSMSMessage>> messageParser(List<SmsMessage> allMessages,
      List<BankSMSMessage> previousMessages) async {
    List<BankSMSMessage> messages = [];
    BankSMSMessage parsedSMS;
    SMSDB smsdb = new SMSDB();
    CARDDB carddb = new CARDDB();
    DateTime durationDate = DateTime.now().subtract(Duration(days: 90));

    for (var element in allMessages) {
      try {
        if (element.body.contains("Card")) {
          var bankName;
          if (element.sender.contains('ICICI')) {
            print('ICICI');
            parsedSMS = iciciParser(element);
            bankName = 'ICICI';
          }
          if (element.sender.contains('AXIS')) {
            print('AXIS');
            parsedSMS = axisParser(element);
            bankName = 'AXIS';
          }
          if (element.sender.contains('HDFC')) {
            print('HDFC');
            parsedSMS = hdfcParser(element);
            bankName = 'HDFC';
          }
          if (element.sender.contains('AMEX')) {
            print('AMEX');
            parsedSMS = amexParser(element);
            bankName = 'AMEX';
          }
          if (element.sender.contains('SBI')) {
            print('SBI');
            parsedSMS = sbiparser(element);
            bankName = 'SBI';
          }

          print(parsedSMS);
          if (parsedSMS != null &&
              (latestDate == null ||
                  parsedSMS.transactionDate.isAfter(latestDate))) {
            print('Something');

            if (!messages.contains(parsedSMS) &&
                !previousMessages.contains(parsedSMS)) {
              if (bankName != null) {
                parsedSMS.info =
                    await cardsProvider.addCard(parsedSMS.cardNo, bankName);
                var obtained = await smsdb.insertSMS(parsedSMS);
                parsedSMS.smsId = obtained[0];
                parsedSMS.description = obtained[1];
                print("################");
                print(parsedSMS.transactionDate.isAfter(durationDate));
                print("############");
                if (parsedSMS.transactionDate.isAfter(durationDate)) {
                  messages.add(parsedSMS);
                }
              }
            }
          }
          // print('Going Forward');
        }
      } catch (error) {
        errorProvider.addError(
          ErrorMessage(
            errorMessage: error.toString(),
            smsMessage: element,
          ),
        );
      }
    }
    print("!!!!!!!!!!!!!!!!!!!!!!!!");
    print(messages);
    print("!!!!!!!!!!!!!!!!");
    return messages;
  }

  BankSMSMessage iciciParser(SmsMessage message) {
    String vendor = "xyx";
    double amountCredited = 10.00;
    String cardNo = "1234";
    double availableBalance = 1000.00;
    DateTime transactionDate = DateTime.now();

    var messageBody = message.body;
    var matchedText;

    //.. code for icici bank parser
    try {
      RegExp vendorRegex = new RegExp(r":.*A");
      RegExp amntCreditRegex =
          new RegExp(r"R+\d+\,+\d+\.\d+\b|R+\d+\.+\d+\b|R\d+,\d+,\d+.\d+\b");
      RegExp cardNoRegex = new RegExp(r"[x|X]{2}\d{4}");
      RegExp avblBlncRegex =
          new RegExp(r"R+\d+\,+\d+\.\d+\b|R+\d+\.+\d+\b|R\d+,\d+,\d+.\d+\b");
      RegExp tanscDateRegex = new RegExp(r"\d{2}-\w+-\d{2}");

      Iterable<RegExpMatch> matches;
      matches = vendorRegex.allMatches(messageBody);

      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        vendor = (matchedText.substring(1, matchedText.length - 2));
      }

      matches = amntCreditRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        amountCredited =
            double.parse(matchedText.substring(1).replaceAll(',', ''));
      }

      matches = cardNoRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        cardNo = (matchedText.substring(2));
      }

      matches = avblBlncRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else if (matches.length == 2) {
        matchedText = matches.elementAt(1).group(0);
        availableBalance =
            double.parse(matchedText.substring(1).replaceAll(',', ''));
      }

      matches = tanscDateRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        //ToDo: Date
        matchedText = matches.elementAt(0).group(0);
        transactionDate = fetchDate(matchedText);
      }

      // print(vendor);
      // print(amountCredited);
      // print(cardNo);
      // print(availableBalance);
      // print(transactionDate);
    } catch (error) {
      errorProvider.addError(
        ErrorMessage(
          errorMessage: error.toString(),
          smsMessage: message,
        ),
      );
    }

    return BankSMSMessage(
      vendor: vendor,
      amountCredited: amountCredited,
      cardNo: cardNo,
      availableBalance: availableBalance,
      transactionDate: transactionDate,
      bankName: 'ICICI',
    );
  }

  BankSMSMessage axisParser(SmsMessage message) {
    String vendor = "xyx";
    double amountCredited = 10.00;
    String cardNo = "1234";
    double availableBalance = 1000.00;
    DateTime transactionDate = DateTime.now();
    var messageBody = message.body;
    var matchedText;
    try {
      //.. code for axis bank parser
      RegExp vendorRegex = new RegExp(r"at\s.*\s+A");
      RegExp amntCreditRegex = new RegExp(r"\b\d+\b");
      RegExp cardNoRegex = new RegExp(r"[x|X]{2}\d{4}");
      RegExp avblBlncRegex = new RegExp(r"R+\d+\b");
      RegExp tanscDateRegex = new RegExp(r"\d{2}-+[a-zA-Z]{3}-+\d{2}");

      Iterable<RegExpMatch> matches;
      matches = vendorRegex.allMatches(messageBody);

      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        vendor = (matchedText.substring(3, matchedText.length - 3));
      }

      matches = amntCreditRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        amountCredited = double.parse(matchedText);
      }

      matches = cardNoRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        cardNo = (matchedText.substring(2));
      }

      matches = avblBlncRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        availableBalance = double.parse(matchedText.substring(1));
      }

      matches = tanscDateRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        //ToDo: Date
        matchedText = matches.elementAt(0).group(0);
        transactionDate = fetchDate(matchedText);
      }

      // print(vendor);
      // print(amountCredited);
      // print(cardNo);
      // print(availableBalance);
      // print(transactionDate);
    } catch (error) {
      errorProvider.addError(
        ErrorMessage(
          errorMessage: error.toString(),
          smsMessage: message,
        ),
      );
    }

    return BankSMSMessage(
      vendor: vendor,
      amountCredited: amountCredited,
      cardNo: cardNo,
      availableBalance: availableBalance,
      transactionDate: transactionDate,
      bankName: 'AXIS',
    );
  }

  BankSMSMessage hdfcParser(SmsMessage message) {
    String vendor = "xyx";
    double amountCredited = 10.00;
    String cardNo = "1234";
    double availableBalance = 1000.00;
    DateTime transactionDate = DateTime.now();
    var messageBody = message.body;
    var matchedText;

    try {
      //.. code for hdfc bank parser
      RegExp vendorRegex = new RegExp(r"at\s.*\son");
      RegExp amntCreditRegex = new RegExp(r"\b\d+\.\d+\b");
      RegExp cardNoRegex = new RegExp(r"[x|X]{2}\d{4}");
      RegExp avblBlncRegex = new RegExp(r"\b\d+\.\d+\b");
      RegExp tanscDateRegex = new RegExp(r"\b\d+-\d+-\d+\b");

      Iterable<RegExpMatch> matches;
      matches = vendorRegex.allMatches(messageBody);

      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        vendor = (matchedText.substring(3, matchedText.length - 3));
      }

      matches = amntCreditRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        amountCredited =
            double.parse(matchedText.substring(0).replaceAll(',', ''));
      }

      matches = cardNoRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        cardNo = (matchedText.substring(2));
      }

      matches = avblBlncRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else if (matches.length == 2) {
        matchedText = matches.elementAt(1).group(0);
        availableBalance =
            double.parse(matchedText.substring(0).replaceAll(',', ''));
      }

      matches = tanscDateRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        //ToDo: Date
        matchedText = matches.elementAt(0).group(0);
        // print(matchedText);
        transactionDate = fetchDate(matchedText);
      }

      // print(vendor);
      // print(amountCredited);
      // print(cardNo);
      // print(availableBalance);
      // print(transactionDate);
    } catch (error) {
      errorProvider.addError(
        ErrorMessage(
          errorMessage: error.toString(),
          smsMessage: message,
        ),
      );
    }

    return BankSMSMessage(
      vendor: vendor,
      amountCredited: amountCredited,
      cardNo: cardNo,
      availableBalance: availableBalance,
      transactionDate: transactionDate,
      bankName: 'HDFC',
    );
  }

  BankSMSMessage amexParser(SmsMessage message) {
    String vendor = "xyx";
    double amountCredited = 10.00;
    String cardNo = "1234";
    double availableBalance = 1000.00;
    DateTime transactionDate = DateTime.now();
    var messageBody = message.body;
    var matchedText;
    try {
      //.. code for amex bank parser
      RegExp vendorRegex = new RegExp(r"at\s.*\son");
      RegExp amntCreditRegex =
          new RegExp(r"\b\d+\,+\d+\.\d+\b|\b\d+\.+\d+\b|\b\d+,\d+,\d+.\d+\b");
      RegExp cardNoRegex = new RegExp(r"\*\*\d{5}");
      // RegExp avblBlncRegex =
      //     new RegExp(r"\b\d+\,+\d+\.\d+\b|\b\d+\.+\d+\b|\b\d+,\d+,\d+.\d+\b");
      RegExp tanscDateRegex = new RegExp(r"\b\d+\/\d+\/\d+\b");

      Iterable<RegExpMatch> matches;
      matches = vendorRegex.allMatches(messageBody);

      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        vendor = (matchedText.substring(3, matchedText.length - 3));
      }

      matches = amntCreditRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        amountCredited = double.parse(matchedText.replaceAll(',', ''));
      }

      matches = cardNoRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        cardNo = (matchedText.substring(2));
      }

      // matches = avblBlncRegex.allMatches(messageBody);
      // if (matches == null || matches.length == 0) {
      //   return null;
      // } else {
      //   matchedText = matches.elementAt(1).group(0);
      //   availableBalance =
      //       double.parse(matchedText.substring(0).replaceAll(',', ''));
      // }

      matches = tanscDateRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        //ToDo: Date
        matchedText = matches.elementAt(0).group(0);
        transactionDate = fetchDate(matchedText);
      }

      // print(vendor);
      // print(amountCredited);
      // print(cardNo);
      // print(availableBalance);
      // print(transactionDate);
    } catch (error) {
      errorProvider.addError(
        ErrorMessage(
          errorMessage: error.toString(),
          smsMessage: message,
        ),
      );
    }

    return BankSMSMessage(
      vendor: vendor,
      amountCredited: 0,
      cardNo: cardNo,
      //availableBalance: availableBalance,
      transactionDate: transactionDate,
      bankName: 'AMEX',
    );
  }

  BankSMSMessage sbiparser(SmsMessage message) {
    String vendor = "xyx";
    double amountCredited = 10.00;
    String cardNo = "1234";
    double availableBalance = 1000.00;
    DateTime transactionDate = DateTime.now();
    var messageBody = message.body;
    var matchedText;
    try {
      //.. code for sbi bank parser
      RegExp vendorRegex = new RegExp(r"at\s.*\son");
      RegExp amntCreditRegex =
          new RegExp(r"\b\d+\,+\d+\.\d+\b|\b\d+\.+\d+\b|\b\d+,\d+,\d+.\d+\b");
      RegExp cardNoRegex = new RegExp(r"\b\d{4}\b");
      // RegExp avblBlncRegex =
      //     new RegExp(r"\b\d+\,+\d+\.\d+\b|\b\d+\.+\d+\b|\b\d+,\d+,\d+.\d+\b");
      RegExp tanscDateRegex = new RegExp(r"\b\d+\/\d+\/\d+\b");

      Iterable<RegExpMatch> matches;
      matches = vendorRegex.allMatches(messageBody);

      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        vendor = (matchedText.substring(3, matchedText.length - 3));
      }

      matches = amntCreditRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        amountCredited = double.parse(matchedText.replaceAll(',', ''));
      }

      matches = cardNoRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        matchedText = matches.elementAt(0).group(0);
        cardNo = (matchedText);
      }

      // matches = avblBlncRegex.allMatches(messageBody);
      // if (matches == null || matches.length == 0) {
      //   return null;
      // } else {
      //   matchedText = matches.elementAt(1).group(0);
      //   availableBalance =
      //       double.parse(matchedText.substring(0).replaceAll(',', ''));
      // }

      matches = tanscDateRegex.allMatches(messageBody);
      if (matches == null || matches.length == 0) {
        return null;
      } else {
        //ToDo: Date
        matchedText = matches.elementAt(0).group(0);
        transactionDate = fetchDate(matchedText);
      }

      // print(vendor);
      // print(amountCredited);
      // print(cardNo);
      // print(availableBalance);
      // print(transactionDate);
    } catch (error) {
      errorProvider.addError(
        ErrorMessage(
          errorMessage: error.toString(),
          smsMessage: message,
        ),
      );
    }

    return BankSMSMessage(
      vendor: vendor,
      amountCredited: amountCredited,
      cardNo: cardNo,
      //availableBalance: 0,
      transactionDate: transactionDate,
      bankName: 'SBI',
    );
  }

  DateTime fetchDate(String sdate) {
    int day;
    int month;
    int year;
    if (sdate.length == 8) {
      day = int.parse(sdate.substring(0, 2));
      month = int.parse(sdate.substring(3, 5));
      year = 2000 + int.parse(sdate.substring(6, 8));
    } else if (sdate.length == 9) {
      day = int.parse(sdate.substring(0, 2));
      year = 2000 + int.parse(sdate.substring(7, 9));
      //Now to check for the month
      month = fetchMonth(sdate.substring(3, 6));
    } else if (sdate.length == 10) {
      if (sdate.contains("-")) {
        day = int.parse(sdate.substring(8, 10));
        month = int.parse(sdate.substring(5, 7));
        year = int.parse(sdate.substring(0, 4));
      } else {
        day = int.parse(sdate.substring(0, 2));
        month = int.parse(sdate.substring(3, 5));
        year = int.parse(sdate.substring(6, 10));
      }
    }
    return DateTime.utc(year, month, day);
  }

  int fetchMonth(String month) {
    if (month == "Jan") {
      return 1;
    } else if (month == "Feb") {
      return 2;
    } else if (month == "Mar") {
      return 3;
    } else if (month == "Apr") {
      return 4;
    } else if (month == "May") {
      return 5;
    } else if (month == "Jun") {
      return 6;
    } else if (month == "Jul") {
      return 7;
    } else if (month == "Aug") {
      return 8;
    } else if (month == "Sep") {
      return 9;
    } else if (month == "Oct") {
      return 10;
    } else if (month == "Nov") {
      return 11;
    } else if (month == "Dec") {
      return 12;
    }
    return -1;
  }
}
