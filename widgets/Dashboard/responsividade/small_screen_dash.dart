import 'package:flutter/material.dart';
import '/widgets/Dashboard/local_navigator_dash.dart';

class SmallScreenDash extends StatelessWidget {
  const SmallScreenDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: localNavigatorDash());
  }
}
