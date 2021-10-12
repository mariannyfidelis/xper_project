import 'package:flutter/material.dart';

class Responsivo extends StatelessWidget {

  final Widget mobile;
  final Widget? tablet;
  final Widget web;

  const Responsivo({Key? key, required this.mobile, required this.web, this.tablet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth >=1200){
        //Estamos na web
        return web;
      }else if(constraints.maxWidth >=800){
        //Estamos utilizando um tablet
        Widget? resTablet = this.tablet;
        if(resTablet != null){
          return resTablet;
        }
        return web;
      }else {
        return mobile;
      }

    });
  }
}
