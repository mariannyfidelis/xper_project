import 'package:flutter/material.dart';

class Controller extends ChangeNotifier{
  String clicado = "";

  mudaClicado(String id) {
    clicado = id;
    notifyListeners();
  }
}