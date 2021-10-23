import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class DonoTable extends StatefulWidget {
  const DonoTable({Key? key}) : super(key: key);

  @override
  _DonoTableState createState() => _DonoTableState();
}

class _DonoTableState extends State<DonoTable> {
  TextEditingController novoDonoController = TextEditingController();
  TextEditingController emailnovoDonoController = TextEditingController();
  TextEditingController idDono = TextEditingController();
  String idProjeto = "2qweqw23133";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ControllerProjetoRepository listaDonosPrincipais2 =
    Get.find<ControllerProjetoRepository>();

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              color: PaletaCores.corLightGrey.withOpacity(.1),
              blurRadius: 12,
            ),
          ],
          border: Border.all(color: PaletaCores.corLightGrey, width: .5)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
              text: "Adicionar Donos",
              color: PaletaCores.corLightGrey,
              weight: FontWeight.bold),
          TextField(
            controller: novoDonoController,
            decoration: InputDecoration(
              labelText: "Nome",
              suffixIcon: Icon(Icons.person_outline),
            ),
          ),
          SizedBox(height: 20),
          TextField(
              controller: emailnovoDonoController,
              decoration: InputDecoration(
                labelText: "Email",
                suffixIcon: Icon(Icons.email),
              )),
          SizedBox(height: 20, width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20, width: 10),
                adicionaBotao(1, "Adicionar dono"),
                SizedBox(width: 20),
                adicionaBotao(3, "Atualizar dono"),
                SizedBox(width: 20),
                adicionaBotao(2, "Sincronizar donos"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                CustomText(
                  text: "Donos",
                  color: PaletaCores.corLightGrey,
                  weight: FontWeight.bold,
                )
              ],
            ),
          ),
          Obx(
            () => DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(
                  label: Text(''),
                  size: ColumnSize.L,
                )
              ],
              rows: List<DataRow>.generate(
                listaDonosPrincipais2.listaDonos.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      //CustomText(text: controller.listDonos[index]),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                                text: listaDonosPrincipais2.listaDonos[index].nome),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                color: Colors.blueGrey,
                                splashRadius: 20,
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  novoDonoController.text = listaDonosPrincipais2
                                      .listaDonos[index].nome
                                      .toString();
                                  emailnovoDonoController.text =
                                      listaDonosPrincipais2.listaDonos[index].email
                                          .toString();
                                  idDono.text = listaDonosPrincipais2
                                      .listaDonos[index].id
                                      .toString();

                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                color: Colors.red,
                                splashRadius: 20,
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  idDono.text = listaDonosPrincipais2
                                      .listaDonos[index].id
                                      .toString();
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => buildAlertDialog(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: Text("Excluir dono"),
      content: Text("Tem certeza ?"),
      actions: [
        TextButton(
            onPressed: () {
              //Get.find<DonoRepository>().removeDono(idDono.text);

              Get.find<ControllerProjetoRepository>()
                  .removeDono(idProjeto, idDono.text);

              novoDonoController.text='';
              Get.back();
            },
            child: Text("Sim")),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Não"))
      ],
    );
  }

  Widget adicionaBotao(int opcao, String textoBotao) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: PaletaCores.active, width: .5),
          color: PaletaCores.corLight,
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: PaletaCores.corLight,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
        ),
        onPressed: () {
          var controlador = Get.find<ControllerProjetoRepository>();

          if (opcao == 1) {

            controlador.addOneDono(
                idProjeto, novoDonoController.text, emailnovoDonoController.text);

            novoDonoController.text = "";
            emailnovoDonoController.text = "";
          } else if (opcao == 2) {
            controlador.sincronizaListaDonos();
          } else if (opcao == 3) {
            controlador.atualizaDono(idProjeto, idDono.text, novoDonoController.text,
                emailnovoDonoController.text);
            novoDonoController.text = '';
            emailnovoDonoController.text = '';
          } else {
            debugPrint(
                "Opção inválida no textfield Dono de Resultados/Metricas");
          }
        },
        child: CustomText(
          text: textoBotao,
          color: PaletaCores.active.withOpacity(.7),
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
