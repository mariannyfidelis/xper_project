import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/components/lista_mensagens.dart';
import '/models/usuario.dart';
import '/utils/paleta_cores.dart';

class MensagensPage extends StatefulWidget {
  final Usuario usuarioDestinatario;

  const MensagensPage(
    this.usuarioDestinatario, {
    Key? key,
  }) : super(key: key);

  @override
  _MensagensPageState createState() => _MensagensPageState();
}

class _MensagensPageState extends State<MensagensPage> {
  late Usuario _usuarioDestinatario;

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  _recuperarDadosIniciais() {
    _usuarioDestinatario = widget.usuarioDestinatario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletaCores.corPrimaria,
        title: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey,
              backgroundImage:
                  CachedNetworkImageProvider(_usuarioDestinatario.urlImagem),
            ),
            SizedBox(width: 30,),
            Text(_usuarioDestinatario.nome, style: TextStyle(fontSize: 18, color: Colors.white),)
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: ListaMensagens(),
      ),
    );
  }
}
