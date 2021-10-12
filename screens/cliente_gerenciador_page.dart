import 'package:flutter/material.dart';

class GerenciadorPage extends StatefulWidget {
  const GerenciadorPage({Key? key}) : super(key: key);

  @override
  _GerenciadorPageState createState() => _GerenciadorPageState();
}

class _GerenciadorPageState extends State<GerenciadorPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Cliente gerenciador",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          color: Colors.orange,
        ),
      ],
    );
  }
}
