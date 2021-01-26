import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/cards_provider.dart';
import 'package:super_app/providers/error_provider.dart';
import 'package:super_app/providers/sms_provider.dart';
import 'package:super_app/widgets/sms_list_tile.dart';
import 'package:super_app/nm_box.dart';
import '../screens/sms_detail_screen.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SMSProvider>(
        context,
        listen: false,
      ).fetchMessages(
        Provider.of<CardsProvider>(
          context,
          listen: false,
        ),
        Provider.of<ErrorProvider>(
          context,
          listen: false,
        ),
      ),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DraggableScrollableSheet(
              minChildSize: 0.68,
              maxChildSize: 1,
              initialChildSize: 0.68,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Neumorphic(
                  style: neuStyleDraggableScrollableSheet(),
                  child: Container(
                    color: Color(0xFF1E2027),
                    child: Consumer<SMSProvider>(
                      builder: (context, parse, child) => parse
                                  .messages.length ==
                              0
                          ? Center(
                              child: Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width / 30),
                                  child: Text(
                                    "Oops! No transactions found.",
                                    style: TextStyle(
                                      color: fCD,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  )),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: parse.messages.length + 1,
                              cacheExtent: 1000000,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      left: 25,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Text(DateFormat.MMMMd().format(
                                            parse.messages[0].transactionDate),
                                          style: TextStyle(color: Color(0xFFD0D3DB),
                                            fontSize: MediaQuery.of(context).size.height / 40,),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.2,
                                              0,
                                              MediaQuery.of(context).size.width / 20,
                                              0),
                                        ),
                                        Text(DateFormat.y().format(
                                            parse.messages[0].transactionDate).substring(0,2),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Color(0xFFD0D3DB),
                                            fontSize: MediaQuery.of(context).size.height / 35,),
                                        ),
                                        Text(DateFormat.y().format(
                                            parse.messages[0].transactionDate).substring(2),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Color(0xFFD0D3DB),
                                            fontSize: MediaQuery.of(context).size.height / 32,),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListTile(
                                      title: SMSListTile(
                                          parse.messages[index - 1], index - 1),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SMSDetailScreen(
                                                    parse.messages[index - 1],
                                                    index - 1),
                                          ),
                                        );
                                      });
                                }
                              }),
                    ),
                  ),
                );
              }),
    );
  }

  NeumorphicStyle neuStyleDraggableScrollableSheet() {
    return NeumorphicStyle(
      shape: NeumorphicShape.flat,
      depth: 15,
      color: Color(0xFF1E2027),
      lightSource: LightSource.bottom,
      intensity: 0.5,
      surfaceIntensity: 0,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
    );
  }
}
