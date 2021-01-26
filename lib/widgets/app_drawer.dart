import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:super_app/nm_box.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1E2027),
        padding: EdgeInsets.all(27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    color: fCD,
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Text(
                  'Hello User,',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD0D3DB)),
                ),
                const Text(
                  'If you liked the app, reach out to us on',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD0D3DB)),
                ),
                SizedBox(height: 50),
                NeumorphicButton(
                  margin: EdgeInsets.only(bottom: 30, top: 5),
                  style: neumorphicDrawerListStyle(),
                  onPressed: launchURLInsta,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 30,
                              0,
                              MediaQuery.of(context).size.width / 30,
                              0),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/1920px-Instagram_logo_2016.svg.png',
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                '@getsuperlife',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Color(0xFFD0D3DB)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                NeumorphicButton(
                  margin: EdgeInsets.only(bottom: 30, top: 5),
                  style: neumorphicDrawerListStyle(),
                  onPressed: launchURLTwitter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 30,
                              0,
                              MediaQuery.of(context).size.width / 30,
                              0),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/en/thumb/9/9f/Twitter_bird_logo_2012.svg/2560px-Twitter_bird_logo_2012.svg.png',
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                '@getsuperlife',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Color(0xFFD0D3DB)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                NeumorphicButton(
                  margin: EdgeInsets.only(bottom: 30, top: 5),
                  style: neumorphicDrawerListStyle(),
                  onPressed: sendMail,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 30,
                              0,
                              MediaQuery.of(context).size.width / 30,
                              0),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Gmail_Icon.svg/2560px-Gmail_Icon.svg.png',
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                '@getsuperlife',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Color(0xFFD0D3DB)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                NeumorphicButton(
                  margin: EdgeInsets.only(bottom: 30, top: 5),
                  style: neumorphicDrawerListStyle(),
                  onPressed: openWeb,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 30,
                              0,
                              MediaQuery.of(context).size.width / 30,
                              0),
                          child: Image.network(
                            'https://images.squarespace-cdn.com/content/5f2eabbdbe1e8b4d760a2119/1596895824088-E3M7JUMCBGYWBS1XT7J9/Frame+7.png?content-type=image%2Fpng',
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                'getsuper.life',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Color(0xFFD0D3DB)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Have a query? Write To Us!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFD0D3DB),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: const Text(
                    '© Super App v1.1 2020 \nCircle Industries Pvt. Ltd., Goregaon East, Mumbai\nAll Rights Reserved',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFD0D3DB),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  launchURLInsta() async {
    const url = "https://www.instagram.com/getsuperlife/";
    await launch(url);
  }
  launchURLTwitter() async {
    const url = "https://www.twitter.com/getsuperlife/";
    await launch(url);
  }
  sendMail() async {
    const url = "mailto:getsuperlife@gmail.com";
    await launch(url);
  }
  openWeb() async {
    const url = "https://www.getsuper.life/";
    await launch(url);
  }
}

class DrawerTile extends StatelessWidget {
  final String listTitle;
  DrawerTile(this.listTitle);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.symmetric(vertical: 5),
      style: neumorphicDrawerListStyle(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          listTitle,
          style: TextStyle(
            color: Color(0xFFD0D3DB),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

NeumorphicStyle neumorphicDrawerListStyle() {
  return const NeumorphicStyle(
    shape: NeumorphicShape.concave,
    //boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
    depth: -2,
    lightSource: LightSource.bottomRight,
    intensity: 0.5,
    surfaceIntensity: 0.1,
    color: Color(0xFF1E2027),
    shadowLightColor: Colors.grey,
  );
}
