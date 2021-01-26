import 'package:sms/sms.dart';

class ErrorMessage {
  final String errorMessage;
  final SmsMessage smsMessage;

  ErrorMessage({
    this.errorMessage,
    this.smsMessage,
  });
}
