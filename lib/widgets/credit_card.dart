import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:super_app/models/card_details.dart';
import 'package:super_app/providers/sms_provider.dart';
import 'package:intl/intl.dart';
import '../nm_box.dart';

class CreditCard extends StatelessWidget {
  final CardDetails cardDetails;
  final bool isClicked;
  final Function selectCard;
  final int cardIndex;var f = new NumberFormat.currency(locale:'en_IN',symbol: "₹",decimalDigits: 2);
  CreditCard(
      {this.cardDetails, this.isClicked, this.selectCard, this.cardIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 30, 0, 0, 0),
      child: GestureDetector(
        onTap: () {
          Provider.of<SMSProvider>(context, listen: false)
              .filterSMS(cardDetails.cardSNo);
          selectCard(cardIndex);
        },
        child: Neumorphic(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 50),
          style: NeumorphicStyle(
              shape: isClicked ? NeumorphicShape.convex : NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: isClicked ? -5 : 5,
              lightSource: LightSource.top,
              intensity: 0.4,
              surfaceIntensity: 0.5,
              color: Color(0xFF1E2027)),
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 70,
                ),
                ColoredBox(
                  color: Color(0xFF694013),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 30,
                            0,
                            MediaQuery.of(context).size.width / 30,
                            0),
                        child: Text(
                            '${cardDetails.cardUid}'.substring(5)
                            +"_"
                            + '${cardDetails.cardUid}'.substring(0,4) ,
                            style: TextStyle(
                                color: Color(0xFFD0D3DB),
                                fontSize:
                                    MediaQuery.of(context).size.height / 70,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 30,
                          0,
                          MediaQuery.of(context).size.width / 30,
                          0),
                      /*child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/200px-Mastercard-logo.svg.png',
                        height: MediaQuery.of(context).size.height / 30,
                      ),*/
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 30, 0, 0, 0),
                          child: Text('Spent - ',
                              style: TextStyle(
                                  color: Color(0xFFD0D3DB),
                                  fontSize:
                                      MediaQuery.of(context).size.height / 80,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 30,
                              MediaQuery.of(context).size.width / 100,
                              MediaQuery.of(context).size.width / 30,
                              0,
                              ),
                          child: Text(
                              f.format(cardDetails.amountSpent)
                                      .toString(),
                              style: TextStyle(
                                  color: Color(0xFFD0D3DB),
                                  fontSize:
                                    f.format(cardDetails.amountSpent)
                                      .toString().length > 9 ?
                                      MediaQuery.of(context).size.height / 40:
                                      MediaQuery.of(context).size.height / 35,
                                  fontWeight: FontWeight.w500)),
                        ),
                        //const SizedBox(height: 1),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(
                        //       MediaQuery.of(context).size.width / 30, 0, 0, 0),
                        //   child: Text('Limit - ₹25,000',
                        //       style: TextStyle(
                        //           color: Color(0xFFD0D3DB),
                        //           fontSize:
                        //               MediaQuery.of(context).size.height / 80,
                        //           fontWeight: FontWeight.w400)),
                        // ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
