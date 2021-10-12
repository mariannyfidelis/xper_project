import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/utils/paleta_cores.dart';

class RedefinicaoSenhaPage extends StatefulWidget {

  const RedefinicaoSenhaPage({Key? key}) : super(key: key);

  @override
  _RedefinicaoSenhaPageState createState() => _RedefinicaoSenhaPageState();
}

class _RedefinicaoSenhaPageState extends State<RedefinicaoSenhaPage> {

  TextEditingController _controllerEmail = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    //double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PaletaCores.corPrimaria,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PaletaCores.corPrimaria,
        centerTitle: true,
        title: Text("Redefinição de Senha", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            width: 500, //larguraTela * 0.8,
            height: alturaTela * 0.4,
            child: Padding(
              padding: EdgeInsets.all(36),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                        labelText: "Email para redefinição",
                        suffixIcon: Icon(Icons.mail_outline)),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        redefinirSenha();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: PaletaCores.corPrimaria),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Redefinir",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => true);
                      //Navigator.pushReplacementNamed(context, "/");
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white30),
                    child: Text("Voltar para login", style: TextStyle(color: PaletaCores.corPrimaria),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void redefinirSenha() {
    _auth.sendPasswordResetEmail(email: _controllerEmail.text).then((value){
      print("Foi enviado um email de redefinição de senha");
      //Navigator.pushReplacementNamed(context, "/");
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => true);
    }).catchError((onError){
      print("erro ao redefinir senha ...");
    });
  }
}
