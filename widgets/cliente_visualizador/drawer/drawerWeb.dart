import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';

class DrawerWeb extends StatelessWidget {
  const DrawerWeb({Key? key}) : super(key: key);

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      // avatar: CircleAvatar(
      //   backgroundColor: Colors.white70,
      //   child: Text(label[0].toUpperCase()),
      // ),
      label: Text(label, style: TextStyle(color: Colors.black)),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 12,
      //semanticLabel: "Filtro para objetivos",
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 20),
                child: Text("Destacar",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Divider(color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                child: Row(
                  children: [Icon(Icons.schedule_rounded), Text("   por Data")],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 35),
              child: Text("Vencendo hoje"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Vencido em "),
                  IconButton(
                      splashRadius: 15,
                      iconSize: 20,
                      onPressed: () {
                        //Mudança de estado da data de Vencimento
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025, 12, 25))
                            .then((value) {
                          var controller = Provider.of<ObjectiveController>(
                              context,
                              listen: false);
                          //print("Data vencimento - ${value!.day.toString()}");
                          // _dataVencimento =
                          //     "${value!.day}/${value.month}/${value.year}";
                          // print("Data vencimento - $_dataVencimento");
                          controller.changeDataVencimento(
                              value!, controller.getObjetivos().first);
                        });
                      },
                      icon: Icon(Icons.date_range
                          //size: 15
                          )),
                ],
              ),
            ),
            Consumer<ObjectiveController>(
                builder: (context, controller, widget) {
              return Padding(
                padding: const EdgeInsets.only(left: 60.0, top: 10),
                child: _buildChip(controller.getObjetivos().first.dataFormatada,
                    Colors.white54),
              );
            }),
            /*Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 18,
                shadowColor: Colors.grey[700],
                child: TextField(
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hoverColor: Colors.grey[100],
                    //suffixIcon: Icon(Icons.schedule),
                    focusColor: Colors.grey[100],
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            )*/
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                child: Row(
                  children: [
                    Icon(Icons.person_search),
                    Text("   por Responsabilidade")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 18,
                shadowColor: Colors.grey[700],
                child: TextField(
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hoverColor: Colors.grey[100],
                    suffixIcon: Icon(
                      Icons.schedule,
                      color: Colors.grey,
                    ),
                    focusColor: Colors.grey[100],
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                child: Row(
                  children: [Icon(Icons.extension), Text("   por Extensão")],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 18,
                shadowColor: Colors.grey[700],
                child: TextField(
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hoverColor: Colors.grey[100],
                    suffixIcon: Icon(
                      Icons.extension,
                      color: Colors.grey,
                    ),
                    focusColor: Colors.grey[100],
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Divider(color: Colors.white),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Compartilhar projeto",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.share)
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Colaboradores online",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.group),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
