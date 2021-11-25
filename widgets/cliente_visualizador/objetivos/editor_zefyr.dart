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
          Container(child: ZefyrToolbar.basic(controller: _controller)),
          Wrap(
            children: [
              OutlinedButton.icon(
                  onPressed: () {
                    print("${_controller.document}");
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  label: Text(
                    "Save document  ",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(width: 30),
              OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.insert_drive_file,
                    color: Colors.black,
                  ),
                  label: Text(
                    "  New document",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
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
