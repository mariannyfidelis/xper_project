import 'package:flutter/material.dart';

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Plataforma GOX - MobileAppbar'),
      centerTitle: true,
      toolbarHeight: 50,
      actions: [
        IconButton(
          iconSize: 15,
          splashRadius: 20,
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
            iconSize: 15,
            splashRadius: 20,
            onPressed: () {},
            icon: Icon(Icons.settings)),
        IconButton(
          iconSize: 15,
          splashRadius: 20,
          onPressed: () {},
          icon: Icon(Icons.more_sharp),
        )
      ],
    );
  }
}
