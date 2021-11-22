import 'package:get/get.dart';
import 'dash_visual_page.dart';
import '/screens/login_page.dart';
import '/utils/paleta_cores.dart';
import '/models/project_model.dart';
import '/services/auth_service.dart';
import 'projeto_pagina_principal.dart';
import 'package:flutter/material.dart';
import '/utils/configuracoes_aplicacao.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/pages/resultados/drop.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class HomeWeb extends StatefulWidget {
  final String? tipo;
  const HomeWeb({Key? key, this.tipo}) : super(key: key);

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
    //late ProjectModel projectAtual;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 117, 119, 139),
        elevation: 10,
        toolbarHeight: 50,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: estiloBotao,
              onPressed: () {
                controllerProjetos.sincronizaListaProjects("publico");
                controllerProjetos.filtragem.value = "publico";
              },
              child: Text(
                "Projetos públicos",
                style: estiloTextoBotao,
              ),
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: estiloBotao,
                onPressed: () {
                  controllerProjetos.sincronizaListaProjects("privado");
                  controllerProjetos.filtragem.value = "privado";
                },
                child: Text(
                  "Seus projetos",
                  style: estiloTextoBotao,
                )),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: estiloBotao,
                onPressed: () {
                  controllerProjetos.sincronizaListaProjects("compartilhado");
                  controllerProjetos.filtragem.value = "compartilhar";
                },
                child: Text(
                  "Compartilhados comigo",
                  style: estiloTextoBotao,
                )),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: estiloBotao,
                onPressed: () {
                  controllerProjetos.sincronizaListaProjects("todos");
                  controllerProjetos.filtragem.value = "todos";
                },
                child: Text(
                  "Todos os projetos",
                  style: estiloTextoBotao,
                )),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Get.find<AuthService>().logout();
              Get.to(() => LoginPage(title: "XPER"), routeName: "/");
            },
            icon: Icon(Icons.logout),
            label: Text("Sair"),
          )
        ],
        title: Text("Tela Projetos"),
      ),
      body: (meusProjetos != null)
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
                                controllerProjetos.atualizaTudo(
                                    meusProjetos[index].idProjeto!);

                                Get.to(
                                    () => ProjetoPage(/*dados do idprojeto*/));

                                //TODO - Enviar dados para a mandala
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                  text: meusProjetos[index].nome,
                                  color: PaletaCores.corPrimaria,
                                  weight: FontWeight.bold,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Obx(() => Visibility(
                                visible:
                                    controllerProjetos.visivelEditarProjeto(),
                                child: IconButton(
                                  splashRadius: 14,
                                  onPressed: () {
                                    alteraNomeProjeto(
                                        meusProjetos[index]
                                            .idProjeto
                                            .toString(),
                                        meusProjetos[index].nome.toString(),
                                        controllerAuth.id.value);
                                  },
                                  icon: Icon(Icons.edit, size: 20),
                                ),
                              )),
                          Obx(() => Visibility(
                              visible:
                                  controllerProjetos.visivelEditarProjeto(),
                              child: IconButton(
                                splashRadius: 14,
                                onPressed: () {
                                  //TODO - Tem que ser no controller para compartilhar o projeto
                                  compartilharProjeto(
                                      meusProjetos[index].idProjeto.toString(),
                                      index);
                                },
                                icon: Icon(Icons.share),
                              ))),
                          Obx(() => Visibility(
                              visible:
                                  controllerProjetos.visivelEditarProjeto(),
                              child: IconButton(
                                  splashRadius: 14,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => buildAlertDialog(
                                          meusProjetos[index]
                                              .idProjeto
                                              .toString(),
                                          controllerAuth.id.value),
                                    );

                                    // controllerProjetos.removeProjeto(
                                    //     meusProjetos[index]
                                    //         .idProjeto
                                    //         .toString(),
                                    //     controllerAuth.usuario!.uid);
                                  },
                                  icon: Icon(Icons.delete)))),
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DashVisual(
                          tipo: widget.tipo,
                        )));
              },
              child: CustomText(
                text: "Dashboard Visual",
                color: PaletaCores.active,
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
            child: Obx(() => Visibility(
                  visible: controllerProjetos.ocultaCriarProjeto(widget.tipo!),
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
                      color: PaletaCores.active,
                      weight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  AlertDialog buildAlertDialog(String idProjeto, String usuario) {
    return AlertDialog(
      title: Text("Excluir Projeto"),
      content: Text("Tem certeza ?"),
      actions: [
        TextButton(
            onPressed: () {
              Get.find<ControllerProjetoRepository>()
                  .removeProjeto(idProjeto, usuario);

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
    var controladorMandala = Get.find<ControllerProjetoRepository>();
    var listaPermissoes = controladorMandala.listaACLs;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Compartilhamento de projeto com outros usuários",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Mensagem a ser enviada email",
                          suffixIcon: Icon(Icons.email),
                        ),
                        controller: mensagem,
                        enableSuggestions: true,
                        enableInteractiveSelection: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(
                        "Colaboradores que atualmente têm acesso:",
                        style: TextStyle(
                            fontSize: 14, fontStyle: FontStyle.normal),
                      ),
                    ),
                    for (int i = 0; i < listaPermissoes.length; i++)
                      Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "${listaPermissoes[i].identificador}",
                                style: estiloTextoBotaoDropMenuButton,
                              )),
                              Text(
                                "${listaPermissoes[i].permissao}",
                                style: estiloTextoBotaoDropMenuButton,
                              ),
                              IconButton(
                                  iconSize: 12,
                                  splashRadius: 14,
                                  color: PaletaCores.corPrimaria,
                                  onPressed: () {
                                    debugPrint(
                                        "Tentando remover ${listaPermissoes[i].identificador}");
                                    controladorMandala.removerACL(
                                        idProjeto,
                                        listaPermissoes[i].identificador!,
                                        listaPermissoes[i].permissao!);
                                  },
                                  icon: Icon(Icons.person_remove))
                            ],
                          )),
                  ],
                ),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailnovoDonoController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            suffixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      //Expanded(child: Container(width: 5,)),
                      Container(height: 70, width: 100, child: DropDown())
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Checkbox(
                              onChanged: (bool? value) {
                                Get.find<ControllerProjetoRepository>()
                                    .mudaTipoPermissaoProjeto(value!);
                                Get.find<ControllerProjetoRepository>()
                                    .tornaProjetoPublico(idProjeto);
                              },
                              value: Get.find<ControllerProjetoRepository>()
                                  .public
                                  .value,
                              activeColor: Color(0xFF6200EE),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                              "Tornar esse projeto público para qualquer pessoa",
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.normal)),
                        ),
                        Expanded(child: Container()),
                        IconButton(
                            splashRadius: 16,
                            onPressed: () {
                              bool verificacaoDono =
                                  novoDonoController.text != "" &&
                                      novoDonoController.text.length > 3;

                              bool verificacaoEmail =
                                  emailnovoDonoController.text != "" &&
                                      emailnovoDonoController.text
                                          .contains("@");
                              if (verificacaoDono && verificacaoEmail) {
                                controladorMandala
                                    .tornaProjetoPublico(idProjeto);

                                controladorMandala.atualizaACL(
                                    idProjeto,
                                    emailnovoDonoController.text,
                                    controladorMandala
                                        .permissaoCompartilhar.string);

                                //TODO: Enviar email de convite

                                debugPrint(
                                    "${novoDonoController.text} de ${emailnovoDonoController.text} - ${controladorMandala.permissaoCompartilhar.string}");

                                novoDonoController.text = "";
                                emailnovoDonoController.text = "";

                                Get.back();
                              }
                            },
                            icon: Icon(Icons.send, size: 18))
                      ],
                    ),
                  )
                ]),
              ),
            ));
  }
}
