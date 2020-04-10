
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  singAno() { 
    _auth.signInAnonymously();
  }

  singwithEmail(String email, String password) async{
    return  await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  registerUser(String email, String password){
    _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

}