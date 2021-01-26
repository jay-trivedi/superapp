import 'package:flutter/foundation.dart';

class CardDetails {
  int cardSNo;
  String cardUid;
  String cardNo;
  String bankName;
  double amountSpent = 0;

  CardDetails({
    this.cardSNo,
    @required this.cardUid,
    @required this.cardNo,
    @required this.bankName,
    this.amountSpent,
  });

  void updateAmount(double extraAmount) {
    this.amountSpent += extraAmount;
  }

  Map<String, dynamic> toMap() {
    return {
      'cardSNo': this.cardSNo,
      'cardUid': this.cardUid,
      'cardNo': this.cardNo,
      'bankName': this.bankName
    };
  }
}
