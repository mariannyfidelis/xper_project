import 'package:get/get.dart';
import 'dash_visual_page.dart';
import '/utils/paleta_cores.dart';
import '/models/project_model.dart';
import '/services/auth_service.dart';
import 'projeto_pagina_principal.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  _HomeWebState createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  TextEditingController novoDonoController = TextEditingController();
  TextEditingController emailnovoDonoController = TextEditingController();
  TextEditingController idDono = TextEditingController();
  TextEditingController mensagem = TextEditingController();
  TextEditingController nomeProjeto = TextEditingController();
  String nome = '';
  var publico = false;

  @override
  Widget build(BuildContext context) {
    final controllerAuth = Get.find<AuthService>();
    final controllerProjetos = Get.find<ControllerProjetoRepository>();
    List<ProjectModel> meusProjetos = controllerProjetos.listaProjetos;
    late ProjectModel projectAtual;

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () =>
                  controllerProjetos.sincronizaListaProjects("publico"),
              child: Text("Projetos públicos")),
          SizedBox(width: 10),
          ElevatedButton(
              onPressed: () =>
                  controllerProjetos.sincronizaListaProjects("privado"),
              child: Text("Seus projetos")),
          SizedBox(width: 10),
          ElevatedButton(
              onPressed: () =>
                  controllerProjetos.sincronizaListaProjects("compartilhado"),
              child: Text("Compartilhados comigo")),
          SizedBox(width: 10),
          ElevatedButton(
              onPressed: () =>
                  controllerProjetos.sincronizaListaProjects("todos"),
              child: Text("Todos os projetos"))
        ],
        title: Text("Tela Projetos"),
      ),
      body: (meusProjetos != null)
          //TODO: Aqui tem que passar os dados para ProjetoPage()
          ? Obx(() => ListView.builder(
                itemCount: meusProjetos.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controllerProjetos.atualizaTudo(meusProjetos[index].idProjeto!);
                                //TODO - Enviar dados para a mandala
                                Get.to(ProjetoPage(/*dados do idprojeto*/));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                  text: meusProjetos[index].nome,
                                  color:
                                      PaletaCores.corPrimaria.withOpacity(.7),
                                  weight: FontWeight.bold,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              splashRadius: 14,
                              onPressed: () {
                                alteraNomeProjeto(
                                    meusProjetos[index].idProjeto.toString(),
                                    meusProjetos[index].nome.toString(),
                                    controllerAuth.usuario!.uid);
                              },
                              icon: Icon(Icons.edit, size: 20)),
                          IconButton(
                              splashRadius: 14,
                              onPressed: () {
                                //TODO - Tem que ser no controller para compartilhar o projeto
                                compartilharProjeto(
                                    meusProjetos[index].idProjeto.toString(),
                                    index);
                              },
                              icon: Icon(Icons.share)),
                          IconButton(
                              splashRadius: 14,
                              onPressed: () {
                                controllerProjetos.removeProjeto(
                                    meusProjetos[index].idProjeto.toString(),
                                    controllerAuth.usuario!.uid);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                      Divider(color: PaletaCores.blackO7)
                    ],
                  ),
                ),
              ))
          : Center(
              child: Text(
                "Ainda não existe projeto !",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: PaletaCores.corPrimaria,
                ),
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 12),
          Container(
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DashVisual()));
              },
              child: CustomText(
                text: "Dashboard Visual",
                color: PaletaCores.active.withOpacity(.7),
                weight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
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
              onPressed: () =>
                  controllerProjetos.addOneProject("Projeto Padrão"),
              child: CustomText(
                text: "Criar Novo Projeto",
                color: PaletaCores.active.withOpacity(.7),
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void alteraNomeProjeto(
      String idProjeto, String nomeAntigo, String idUsuario) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Renomear projeto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              contentPadding: EdgeInsets.zero,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                        controller: nomeProjeto,
                        decoration: InputDecoration(
                          labelText: "Nome do projeto",
                          suffixIcon: Icon(Icons.grading),
                        )),
                  ),
                ]),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (nomeProjeto.text.isEmpty) {
                        nome = nomeAntigo;
                      } else {
                        nome = nomeProjeto.text;
                      }
                      nomeProjeto.text = nome;
                      Get.find<ControllerProjetoRepository>()
                          .atualizaNomeProjeto(idProjeto, nomeProjeto.text,
                              idUsuario: idUsuario);

                      nomeProjeto.text = "";
                      Get.back();
                    },
                    child: Text("Sim")),
                TextButton(onPressed: () => Get.back(), child: Text("Não"))
              ],
            ));
  }

  //TODO - Implementar compartilharProjeto
  void compartilharProjeto(String idProjeto, int index) {
    debugPrint("compartilhar projeto");
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Compartilhamento de projeto com outros usuários",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextField(
                    controller: mensagem,
                    enableSuggestions: true,
                    enableInteractiveSelection: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      "Colaboradores que atualmente têm acesso:",
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.normal),
                    ),
                  ),
                  for (int i = 0; i < 3; i++)
                    Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Pessoa $i",
                            )),
                            Text("É dono")
                          ],
                        )),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            publico = value!;
                          });
                        },
                        value: publico,
                        activeColor: Color(0xFF6200EE),
                      ),
                      Text("Tornar esse projeto público para qualquer pessoa",
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.normal))
                    ],
                  )
                ]),
              ),
            ));
  }
}
