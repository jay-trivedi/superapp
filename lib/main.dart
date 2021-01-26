import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/cards_provider.dart';
import 'package:super_app/providers/error_provider.dart';
import 'package:super_app/providers/sms_provider.dart';
import 'package:super_app/screens/debug_screen.dart';
import './screens/home_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SMSProvider()),
        ChangeNotifierProvider(create: (ctx) => CardsProvider()),
        ChangeNotifierProvider(create: (ctx) => ErrorProvider()),
      ],
      child: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Super App',
        themeMode: ThemeMode.dark,
        theme: NeumorphicThemeData(
          baseColor: Color(0XFFE9EDF0),
          //baseColor: Colors.white,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        darkTheme: NeumorphicThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          baseColor: Color(0xFF1E2027),
          lightSource: LightSource.topLeft,
          depth: 6,
        ),
        home: HomePage(),
        routes: {
          DebugScreen.routeName: (ctx) => DebugScreen(),
        },
      ),
    );
  }
}
