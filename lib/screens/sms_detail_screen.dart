import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_app/models/sms_message.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:super_app/nm_box.dart';
import 'package:intl/intl.dart';
import 'package:super_app/providers/sms_provider.dart';

class SMSDetailScreen extends StatefulWidget {
  final BankSMSMessage message;
  final int index;
  SMSDetailScreen(this.message, this.index);

  @override
  _SMSDetailScreenState createState() => _SMSDetailScreenState();
}

class _SMSDetailScreenState extends State<SMSDetailScreen> {
  TextEditingController _controller;

  bool isEditing;

  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.message.description);
    isEditing = widget.message.description != null ? false : true;

  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  var f = new NumberFormat.currency(locale:'en_IN',symbol: "₹",decimalDigits: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height / 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height / 120,
                  0,
                  MediaQuery.of(context).size.height / 120,
                  0
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    f.format(widget.message.amountCredited).toString(),
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height / 25,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 70,
                  ),
                  Text(
                    "To " + widget.message.vendor,
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height / 60,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height / 120,
                  MediaQuery.of(context).size.height/120,
                  MediaQuery.of(context).size.height / 120,
                  0,
                  ),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                       widget.message.info.cardUid.toString().substring(5)
                          + "_"
                          + widget.message.info.cardUid.toString().substring(0,4),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 60),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0XFF694013),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 200,
                        horizontal: MediaQuery.of(context).size.width / 50),
                    margin: EdgeInsets.fromLTRB(
                        0.0,
                        MediaQuery.of(context).size.height / 200,
                        MediaQuery.of(context).size.height / 55,
                        MediaQuery.of(context).size.height / 200),
                  ),
                  Text(
                    '***',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.message.cardNo.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height / 120,
                  MediaQuery.of(context).size.height/50,
                  MediaQuery.of(context).size.height / 120,
                  0,
                  ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height / 120),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height / 40,
                      semanticLabel: 'Date of Transaction',
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM, yyyy')
                        .format(widget.message.transactionDate),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(

              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height / 120,
                  MediaQuery.of(context).size.height/50,
                  MediaQuery.of(context).size.height / 120,
                  MediaQuery.of(context).size.height / 100,
                  ),

              child: Text(
                "Description: ",
                style: TextStyle(
                  color: Colors.grey,

                  fontSize: MediaQuery.of(context).size.height / 55,
                ),
              ),
            ),
            !(isEditing)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height / 120),
                        child: Text(
                          widget.message.description,
                          style: TextStyle(
                            color: fCD,
                            fontSize: MediaQuery.of(context).size.height / 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 120),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Color(0XFFFFFFFF),
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height / 120),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0XFFE9EDF0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(width: 0.5, color: fCD),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(width: 1, color: fCD)),
                        hintText: "Transaction Description",
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 60,
                            color: Color(0xFFB3B1B1)),
                      ),
                      controller: _controller,
                      onSubmitted: (String value) {
                        widget.message.description = value;
                        Provider.of<SMSProvider>(context, listen: false)
                            .editMessageDescription(widget.index, value);
                        setState(() {
                          isEditing = false;
                        });
                      },
                    ),
                  ),

          ],
        ),
      ),
    );
  }

  neuStyleSMSListTile() {
    return NeumorphicStyle(
      shape: NeumorphicShape.convex,
      depth: -3,
      color: Colors.white,
      lightSource: LightSource.topLeft,
      intensity: 0.8,
      surfaceIntensity: 0.5,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
    );
  }
}

