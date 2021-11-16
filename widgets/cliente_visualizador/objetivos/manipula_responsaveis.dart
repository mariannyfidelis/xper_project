import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import '/utils/configuracoes_aplicacao.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaResponsaveis extends StatefulWidget {
  const ManipulaResponsaveis({Key? key}) : super(key: key);

  @override
  _ManipulaResponsaveisState createState() => _ManipulaResponsaveisState();
}

class _ManipulaResponsaveisState extends State<ManipulaResponsaveis> {
  TextEditingController responsavelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    return Obx(
      () => Visibility(
        visible: mandalaController.visivel.value,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Responsáveis   ", style: estilo_teste),
                    SizedBox(width: 20),
                    Container(
                        width: 250,
                        child: TextField(
                          style: estilo_teste,
                          controller: responsavelController,
                          textAlign: TextAlign.justify,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintStyle: estilo_teste,
                              hintText: "Adicione colaborador",
                              focusColor: PaletaCores.textColor,
                              prefixIcon: Icon(
                                Icons.people,
                                size: 20,
                                color: PaletaCores.textColor,
                              ),
                              suffixIcon: IconButton(
                                  color: PaletaCores.textColor,
                                  splashRadius: 16,
                                  onPressed: () {
                                    (responsavelController.text.trim() != "")
                                        ? buildAlertDialog(
                                            responsavelController)
                                        : () {};
                                  },
                                  icon: Icon(Icons.person_add, size: 14)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 32.0),
                                borderRadius: BorderRadius.circular(10),
                              )),
                          maxLength: 450,
                          keyboardType: TextInputType.text,
                        )),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                    IconButton(
                        color: PaletaCores.textColor,
                        splashRadius: 16,
                        onPressed: listarDonos,
                        icon: Icon(Icons.list_alt, size: 14))
                  ],
                ),
                Obx(
                  () => Expanded(
                      child: Text("${mandalaController.responsaveis}")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAlertDialog(TextEditingController responsavel) {
    TextEditingController controllerNome = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();

    if (responsavel.text.contains("@")) {
      controllerEmail = responsavel;
      controllerNome.text = "";
    } else {
      controllerNome = responsavel;
      controllerEmail.text = "";
    }
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text("Adicione um Dono"),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controllerNome,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          suffixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          labelText: "Email",
                          suffixIcon: Icon(Icons.email),
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      child:
                          Text("Cancelar", style: estiloTextoBotaoAlertDialog),
                      onPressed: () {
                        Get.back();
                      }),
                  SizedBox(width: 14),
                  TextButton(
                    onPressed: () {
                      Get.find<AuthService>().registrarDono(
                        controllerNome.text,
                        controllerEmail.text,
                        controllerEmail.text,
                      );
                      controllerNome.text = "";
                      controllerEmail.text = "";
                      responsavel.text = "";
                      Get.back();
                    },
                    child:
                        Text("Adicionar", style: estiloTextoBotaoAlertDialog),
                  ),
                ]));
  }

  listarDonos() {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) => AlertDialog(
              title: Column(

                  children: [
                Text(
                  "Responsáveis",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Nome',
                          style: TextStyle(
                              color: PaletaCores.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: Container(width: 25)),
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                color: PaletaCores.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ]),
              content: Container(
                height: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (mandalaController.ultimoNivelClicado.value == 2)
                        if (mandalaController
                                .listaObjectives[
                                    mandalaController.indiceObjective.value]
                                .donos!
                                .length >
                            0)
                          for (int i = 0;
                              i <
                                  mandalaController
                                      .listaObjectives[mandalaController
                                          .indiceObjective.value]
                                      .donos!
                                      .length;
                              i += 2)
                            Row(
                              children: [
                                Text(
                                    '${mandalaController.listaObjectives[mandalaController.indiceObjective.value].donos![i]}',
                                    style: estiloTextoBotaoDropMenuButton),
                                //SizedBox(width: 25),
                                Expanded(child: Container(width: 25)),
                                Text(
                                  '${mandalaController.listaObjectives[mandalaController.indiceObjective.value].donos![i + 1]}',
                                  style: estiloTextoBotaoDropMenuButton,
                                ),
                                // IconButton(
                                //     color: PaletaCores.corPrimaria,
                                //     splashRadius: 16,
                                //     onPressed: () =>
                                //         mandalaController.adicionarResponsavel(
                                //             responsavelController.text),
                                //     icon: Icon(Icons.person_remove, size: 10),
                                // )
                              ],
                            ),
                      if (mandalaController.ultimoNivelClicado.value == 3)
                        if (mandalaController
                                .listaResultados[
                                    mandalaController.indiceResult.value]
                                .donoResultado!
                                .length >
                            0)
                          for (int i = 0;
                              i <
                                  mandalaController
                                      .listaResultados[
                                          mandalaController.indiceResult.value]
                                      .donoResultado!
                                      .length;
                              i += 2)
                            Row(
                              children: [],
                            ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
