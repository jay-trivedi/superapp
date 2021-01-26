import 'package:flutter/foundation.dart';
import 'package:super_app/models/error_message.dart';

class ErrorProvider extends ChangeNotifier {
  List<ErrorMessage> _errors = [];

  get errorMessages {
    return [..._errors];
  }

  void addError(ErrorMessage message) {
    _errors.add(message);
    notifyListeners();
  }
}
