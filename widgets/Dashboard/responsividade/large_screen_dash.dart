import 'package:flutter/material.dart';
import '/widgets/Dashboard/local_navigator_dash.dart';
import '/widgets/Dashboard/menu_dash/side_menu_dash.dart';

class LargeScreenDash extends StatelessWidget {
  const LargeScreenDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideMenuDash(),
        ),
        Expanded(
          flex: 5,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: localNavigatorDash()),
        ),
      ],
    );
  }
}
