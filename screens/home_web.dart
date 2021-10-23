import 'package:get/get.dart';
import 'dash_visual_page.dart';
import '/utils/paleta_cores.dart';
import '/models/project_model.dart';
import 'projeto_pagina_principal.dart';
import 'package:flutter/material.dart';
import '/controllers/projectsRepository.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';

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
  var publico = false;

  @override
  Widget build(BuildContext context) {
    final listaProjetos = Get.find<ProjectsRepository>();

    List<ProjectModel> meusProjetos = listaProjetos.lista;
    late ProjectModel projectAtual;

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: () {}, child: Text("Projetos públicos")),
          SizedBox(width: 10,),
          ElevatedButton(onPressed: () {}, child: Text("Seus projetos")),
          SizedBox(width: 10,),
          ElevatedButton(onPressed: () {}, child: Text("Compartilhados comigo"))
        ],
        title: Expanded(child: Text("Tela Projetos")),
      ),
      body: (meusProjetos != null)
          //TODO: Aqui tem que passar os dados para ProjetoPage()
          ? ListView.builder(
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
                              debugPrint("cliquei na linha");
                              Get.to(ProjetoPage());
                            },
                            child: CustomText(
                              text: meusProjetos[index].nome,
                              color: PaletaCores.corPrimaria.withOpacity(.7),
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          splashRadius: 14,
                          onPressed: () {
                            atualizarNomeProjeto();
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        ),
                        IconButton(
                            splashRadius: 14,
                            onPressed: () {
                              compartilharProjeto();
                            },
                            icon: Icon(Icons.share)),
                        IconButton(
                            splashRadius: 14,
                            onPressed: () {
                              deletarProjeto();
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                    Divider(
                      color: PaletaCores.blackO7,
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
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
              onPressed: () {},
              child: CustomText(
                text: "Listar Projetos",
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
              onPressed: () {},
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

  void atualizarNomeProjeto() {
    debugPrint("atualizar projeto");
  }

  void compartilharProjeto() {
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

  void deletarProjeto() {
    debugPrint("deletar projeto");
  }
}
