import 'dart:io';
import 'dart:typed_data';

import 'package:get/get_connect/http/src/http/html/file_decoder_html.dart';

Future<Uint8List?> _readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File file = new File.fromUri(myUri);
  Uint8List? bytes;

  await file.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print('Exception Error while reading audio from path:' +
        onError.toString());
  });
  return bytes;
}

Uint8List? convertUint8list(){
  try{
    Uint8List? fileByte;
    String myPath= 'assets/images/perfil.png';
    _readFileByte(myPath).then((bytesData) {
      fileByte = bytesData!;
      //do your task here
      print("deu certo converter");
    });

    return fileByte;
  } catch (e) {
    // if path invalid or not able to read
    print(e);
    print("nao deu certo converter a imagem para uint8list !");
  }

}