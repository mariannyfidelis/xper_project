import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController{

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario = null.obs as User?;
  bool isLoading = true.obs as bool;

  AuthService(){
    _authCheck();
  }

  _authCheck(){
   _auth.authStateChanges().listen((User? user) {
     usuario = (user == null) ? null : user;
     isLoading = false;
     update();
   });
  }
}