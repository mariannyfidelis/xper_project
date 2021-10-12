import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

class EditorNotas extends StatefulWidget {
  const EditorNotas({Key? key}) : super(key: key);

  @override
  _EditorNotasState createState() => _EditorNotasState();
}

class _EditorNotasState extends State<EditorNotas> {
  ZefyrController _controller = ZefyrController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.minPositive,
      color: Colors.white38,
      child: Column(
        children: [
          ZefyrToolbar.basic(controller: _controller),
          Expanded(
            child: ZefyrEditor(
              padding: const EdgeInsets.all(12.0),

              //clipboardController: ClipboardController(),
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
