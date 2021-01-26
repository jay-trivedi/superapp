import 'package:flutter/foundation.dart';
import 'card_details.dart';

class BankSMSMessage {
  int smsId;
  final String vendor;
  final double amountCredited;
  final String cardNo;
  final String bankName;
  double availableBalance = 0;
  final DateTime transactionDate;
  CardDetails info;
  String description = '';

  BankSMSMessage(
      {this.smsId,
      @required this.vendor,
      @required this.amountCredited,
      @required this.cardNo,
      @required this.bankName,
      this.availableBalance,
      @required this.transactionDate,
      this.info,
      this.description});

  void editDescription(String descp) {
    this.description = descp;
  }

  Map<String, dynamic> toMap() {
    return {
      'smsId': this.smsId,
      'vendor': this.vendor,
      'amountCredited': this.amountCredited,
      'cardNo': this.cardNo,
      'availableBalance': this.availableBalance,
      'transactionDate': this.transactionDate.millisecondsSinceEpoch,
      'cardId': this.info.cardSNo,
      'description': this.description,
      'bankName': this.bankName,
    };
  }

  String printMessage() {
    String output =
        "smsId: ${this.smsId}\nvendor: ${this.vendor}\namountCredited: ${this.amountCredited}\ncardNo: ${this.cardNo}\navailableBalance: ${this.availableBalance}\ntransactionDate: ${this.transactionDate}\nbankName: ${this.bankName}\ndescription: ${this.description}\ncardId: ${this.info.cardSNo}";
    return output;
  }
}
