import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:super_app/screens/debug_screen.dart';
import 'package:super_app/widgets/app_drawer.dart';
import '../widgets/feed.dart';
import '../widgets/insights.dart';
import '../widgets/history.dart';
import 'package:super_app/nm_box.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: new AppDrawer(),
      appBar: NeumorphicAppBar(
          leading: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 80),
            child: NeumorphicButton(
              style: neuStyleButton(),
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 65),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              child: NeumorphicIcon(
                Icons.menu,
                size: MediaQuery.of(context).size.height / 30,
                style: neuStyleIcon(),
              ),
            ),
          ),
          actions: <Widget>[
            /*
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 80),
              child: NeumorphicButton(
                  style: neuStyleButton(),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 65),
                  child: NeumorphicIcon(
                    Icons.search,
                    size: MediaQuery.of(context).size.height / 30,
                    style: neuStyleIcon(),
                  )),
            ),*/
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 80),
              child: NeumorphicButton(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: 20,
                      lightSource: LightSource.top,
                      intensity: 0,
                      //color: Color(0xFF1E2027)
                      color: Color(0XFFD0D3DB)),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 65),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      DebugScreen.routeName,
                    );
                  },
                  child: NeumorphicIcon(
                    Icons.notifications,
                    size: MediaQuery.of(context).size.height / 30,
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(18)),
                        depth: 20,
                        lightSource: LightSource.top,
                        color: Color(0xFF1E2027)),
                  )),
            )
          ]),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Feed(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(
              //       MediaQuery.of(context).size.height / 40,
              //       MediaQuery.of(context).size.height / 200,
              //       MediaQuery.of(context).size.height / 40,
              //       MediaQuery.of(context).size.height / 80),
              //   child: Text('Insights',
              //       style: TextStyle(
              //           color: Color(0xFFD0D3DB),
              //           fontSize: MediaQuery.of(context).size.height / 35,
              //           fontWeight: FontWeight.w500)),
              // ),
              // Insights(),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 100,
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 80),
                child: Text('History',
                    style: TextStyle(
                        color: Color(0xFFD0D3DB),
                        fontSize: MediaQuery.of(context).size.height / 35,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          History(),
        ],
      ),
    );
  }

  //This is the function to return the neumorphic style for button
  neuStyleButton() {
    return NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 20,
        lightSource: LightSource.top,
        intensity: 0,
        color: Color(0xFF1E2027));
  }

  //This is the function to return the neumorphic style for icons
  neuStyleIcon() {
    return NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
        depth: 20,
        lightSource: LightSource.top,
        color: Color(0XFFD0D3DB));
  }
}
