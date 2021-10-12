import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationControllerDash extends GetxController {
  static NavigationControllerDash instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigationKey.currentState!.pop();
}
