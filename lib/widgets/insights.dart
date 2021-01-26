import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Insights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFF1E2027);
    return Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 20,
          MediaQuery.of(context).size.height / 100,
          MediaQuery.of(context).size.width / 20,
          MediaQuery.of(context).size.height / 100),
      color: Color(0xFF1E2027),
      // color: Colors.white,
      child: ClayContainer(
        color: baseColor,
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 1.1,
      ),
    );
  }
}
