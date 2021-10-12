// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DatabaseService {
//   final String uid;

//   DatabaseService({required this.uid});

//   final CollectionReference userCollection =
//       FirebaseFirestore.instance.collection('usuarios');

//   Future deleteuser() {
//     return userCollection.doc(uid).delete();
//   }
// }


// class AuthService {


// Future deleteUser(String email, String id) async {
//     try {
//       User user =  FirebaseAuth.instance.currentUser!;


//       await DatabaseService(uid: id).deleteuser(); // called from database class
//       await user.delete();
//       return true;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }