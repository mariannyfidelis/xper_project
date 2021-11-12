import 'package:flutter/material.dart';
import '/widgets/Dashboard/local_navigator_gestor.dart';
import '/widgets/Dashboard/menu_dash/side_menu_gestor.dart';

class LargeScreenGestor extends StatelessWidget {
  const LargeScreenGestor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideMenuGestor(),
        ),
        Expanded(
          flex: 5,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: localNavigatorGestor()),
        ),
      ],
    );
  }
}
