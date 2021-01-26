import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:super_app/models/sms_message.dart';
import 'package:super_app/nm_box.dart';
import '../screens/sms_detail_screen.dart';
import 'package:intl/intl.dart';

class SMSListTile extends StatelessWidget {
  final BankSMSMessage message;
  int index;
  SMSListTile(this.message, this.index);
  var f = new NumberFormat.currency(locale:'en_IN',symbol: "₹",decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 30,
        //top: MediaQuery.of(context).size.height / 100,
      ),
      style: neuStyleSMSListTile(),
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        f.format(message.amountCredited).toString(),
                        style: TextStyle(
                          color: Color(0xFFD0D3DB),
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.height / 40,
                        ),
                      ),
                      Text(
                        "   To " + message.vendor 
                        + " : "
                        + DateFormat('dd MMM').format(message.transactionDate)
                        ,
                        style: TextStyle(
                          color: Color(0xFFD0D3DB),
                          fontSize: MediaQuery.of(context).size.height / 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          message.info.cardUid.toString().substring(5)
                          + "_"
                          + message.info.cardUid.toString().substring(0,4),
                          style: TextStyle(
                              color: Color(0xFFD0D3DB),
                              fontSize:
                                  MediaQuery.of(context).size.height / 80),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Color(0XFF694013),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5,
                            horizontal:
                                MediaQuery.of(context).size.width / 150),
                        margin: EdgeInsets.fromLTRB(
                            0.0, 1, MediaQuery.of(context).size.width / 50, 5),
                      ),
                      Text(
                        '  **** ',
                        style: TextStyle(
                          color: Color(0xFFD0D3DB),
                          fontSize: MediaQuery.of(context).size.height / 70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        message.cardNo.toString(),
                        style: TextStyle(
                          color: Color(0xFFD0D3DB),
                          fontSize: MediaQuery.of(context).size.height / 70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 7,
                        0,
                        MediaQuery.of(context).size.width / 100,
                        0),
                    /*child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/d/de/Amazon_icon.png',
                      height: 30,
                    ),*/
                  ),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: MediaQuery.of(context).size.height / 30,
                    color: Color(0xFFD0D3DB),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SMSDetailScreen(message, index),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  neuStyleSMSListTile() {
    return NeumorphicStyle(
      shape: NeumorphicShape.flat,
      depth: -5,
      color: Color(0xFF1E2027),
      lightSource: LightSource.topLeft,
      intensity: 0.5,
      surfaceIntensity: 0.5,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
    );
  }
}
