import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_app/models/error_message.dart';
import 'package:super_app/providers/error_provider.dart';

class DebugScreen extends StatelessWidget {
  static const routeName = "/debug";

  @override
  Widget build(BuildContext context) {
    List<ErrorMessage> errorMessages =
        Provider.of<ErrorProvider>(context).errorMessages;
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug'),
      ),
      body: ListView.builder(
        itemCount: errorMessages.length,
        itemBuilder: (context, index) => Card(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Error Message'),
                  Text(errorMessages[index].errorMessage),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sender'),
                  Text(
                    errorMessages[index].smsMessage.sender,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Body'),
                  Text(
                    errorMessages[index].smsMessage.body,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
