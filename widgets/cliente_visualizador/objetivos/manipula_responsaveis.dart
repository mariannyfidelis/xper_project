import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';

class ManipulaResponsaveis extends StatelessWidget {
  const ManipulaResponsaveis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectiveController>(
        builder: (context, controller, widget) {
      return Visibility(
        visible: controller.visivel,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Responsáveis"),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: 250,
                    child: TextField(
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.people,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      maxLength: 450,
                      keyboardType: TextInputType.text,
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
