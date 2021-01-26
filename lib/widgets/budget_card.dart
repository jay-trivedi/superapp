import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/cards_provider.dart';
import 'package:super_app/providers/sms_provider.dart';
import 'package:intl/intl.dart';
import '../nm_box.dart';

class Budget extends StatelessWidget {
  var amt = 100000.0;
  final isClicked;
  final Function selectCard;
  var f = new NumberFormat.currency(locale:'en_IN',symbol: "₹",decimalDigits: 2);
  Budget(this.isClicked, this.selectCard);
  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardsProvider>(context, listen: true);
    final cards = cardsProvider.cards;
    var total = 0.0;
    for (int i = 0; i < cards.length; i++) {
      total += cards[i].amountSpent;
    }
    return GestureDetector(
      onTap: () {
        Provider.of<SMSProvider>(context, listen: false).filterSMS(null);
        selectCard(0);
      },
      child: Neumorphic(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 120),
        style: NeumorphicStyle(
            shape: isClicked ? NeumorphicShape.convex : NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
            depth: isClicked ? -5 : 5,
            lightSource: isClicked ? LightSource.topLeft : LightSource.top,
            intensity: 0.4,
            //surfaceIntensity: 0.2,
            color: Color(0xFF1E2027)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 30,
              MediaQuery.of(context).size.height / 80,
              MediaQuery.of(context).size.width / 30,
              MediaQuery.of(context).size.height / 80),
          //decoration: nMbox,
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'This month',
                    style: TextStyle(
                        color: Color(0xFFD0D3DB),
                        fontSize: MediaQuery.of(context).size.height / 60,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        f.format(total).toString(),
                          style: TextStyle(
                              color: Color(0xFFD0D3DB),
                              fontSize: 
                              f.format(total).toString()
                              .length > 11 ?
                              MediaQuery.of(context).size.width / 20:
                              MediaQuery.of(context).size.width / 17,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 70),
              NeumorphicProgress(
                height: MediaQuery.of(context).size.height / 90,
                percent: 1,
                style: ProgressStyle(
                  accent: Color(0xFFD0D3DB),
                  variant: Color(0xFFD0D3DB),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 85,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text('Your Budget: ₹' + amt.toString(),
                  //     style: TextStyle(
                  //         color: Color(0xFFD0D3DB),
                  //         fontSize: MediaQuery.of(context).size.height / 75,
                  //         fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
