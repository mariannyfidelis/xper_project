import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '/utils/paleta_cores.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnexoPage extends StatefulWidget {
  const AnexoPage({Key? key}) : super(key: key);

  @override
  _AnexoPageState createState() => _AnexoPageState();
}

class _AnexoPageState extends State<AnexoPage> {
  var auth = Get.find<AuthService>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uint8List? _arquivoImagemSelecionado;

  @override
  Widget build(BuildContext context) {
    void _selecionarImagem() async {
      FilePickerResult? resultado = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      //Recuperar arquivo
      setState(() {
        _arquivoImagemSelecionado = resultado?.files.single.bytes;
      });
    }

    void _uploadImagem(User? usuario) {
      Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
      FirebaseStorage _storage = FirebaseStorage.instance;
      var imageId = Uuid();

      if (arquivoSelecionado != null) {
        Reference imagePerfilRef = _storage.ref(
            "usuario/id_usuario_${usuario!.uid}/projeto_${usuario.uid}/image/${imageId.v4()}.jpg");
        UploadTask uploadtask = imagePerfilRef.putData(arquivoSelecionado);
        uploadtask.whenComplete(() async {
          String urlImagem = await uploadtask.snapshot.ref.getDownloadURL();
          print("deu certo taí o link $urlImagem!!!");

          final usuariosRef = _firestore.collection("anexos");
          usuariosRef.doc("${usuario.uid}").update({
            'Images': [arquivoSelecionado]
          }).then((value) {
            //Rotas para outra tela
          });
        });
      } else {
        final usuariosRef = _firestore.collection("anexos");
        usuariosRef.doc("${usuario!.uid}").update({
          'Images': [arquivoSelecionado]
        }).then((value) {
          //Rotas para outra tela
        });
      }
    }

    void _selecionarPDF() async {
      FilePickerResult? resultado = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      //Recuperar arquivo
      setState(() {
        _arquivoImagemSelecionado = resultado?.files.single.bytes;
      });
    }

    void _uploadPDF(User? usuario) {
      Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
      FirebaseStorage _storage = FirebaseStorage.instance;
      var imageId = Uuid();

      if (arquivoSelecionado != null) {
        Reference imagePerfilRef = _storage.ref(
            "usuario/id_usuario_${usuario!.uid}/projeto_${usuario.uid}/PDF/${imageId.v4()}.pdf");
        UploadTask uploadtask = imagePerfilRef.putData(arquivoSelecionado);
        uploadtask.whenComplete(() async {
          String urlImagem = await uploadtask.snapshot.ref.getDownloadURL();
          print("deu certo taí o link $urlImagem!!!");

          final usuariosRef = _firestore.collection("anexos");
          usuariosRef.doc("${usuario.uid}").update({
            'Images': [arquivoSelecionado]
          }).then((value) {
            //Rotas para outra tela
          });
        });
      } else {
        final usuariosRef = _firestore.collection("anexos");
        usuariosRef.doc("${usuario!.uid}").update({
          'Images': [arquivoSelecionado]
        }).then((value) {
          //Rotas para outra tela
        });
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
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
                  onPressed: _selecionarImagem,
                  child: CustomText(
                    text: "Anexar imagem",
                    color: PaletaCores.active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: 12),
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
                    _uploadImagem(auth.usuario);
                  },
                  child: CustomText(
                    text: "Upload imagem",
                    color: PaletaCores.active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                )),
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
                  onPressed: _selecionarPDF,
                  child: CustomText(
                    text: "Anexar PDF",
                    color: PaletaCores.active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: 12),
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
                    _uploadPDF(auth.usuario);
                  },
                  child: CustomText(
                    text: "Upload PDF",
                    color: PaletaCores.active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: 25),
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
                Navigator.of(context).pop();
              },
              child: CustomText(
                text: "Voltar para Projetos",
                color: PaletaCores.active.withOpacity(.7),
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}