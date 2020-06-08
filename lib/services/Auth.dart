import 'package:firebase_auth/firebase_auth.dart';

import 'package:watterplannet/class/data.dart';

class Authentication  {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static AuthResult result;
  String code;

   

  singOut() => _auth.signOut();

  loginWithEmailAndPassword(String email, String password) async 
  {
     try 
     {
            result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());

            FirebaseUser user = result.user;

            // TODO Revisar como cargo los productos
            return user;

     }catch (error)
     {
      messageError(error);
      return code;
     }
  }

   Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  logoutUser() {
    _auth.signOut();
  }

  registerUser(String email, String password) async 
  {
    try {
          result = await  _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      
          FirebaseUser user = result.user;
          user.sendEmailVerification();
          return user;

    }catch(error){
      messageError(error);
      return code;
    }
    
  }

  void messageError(var e) {
    switch (e.code) {
      case 'ERROR_WEAK_PASSWORD':
        code = 'the password is not strong enough.';
        break;
      case 'ERROR_INVALID_EMAIL':
        code = 'the email address is malformed.';
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        code = 'the email is already in use by a different account.';
        break;
      case 'ERROR_INVALID_EMAIL':
        code = 'The email you specifed was not valid.';
        break;
      case 'ERROR_USER_NOT_FOUND':
        code = 'The user could not be found.';
        break;
      case 'ERROR_USER_DISABLED':
        code = 'This user\'s account was disabled.';
        break;
      case 'ERROR_WRONG_PASSWORD':
        code = 'The password you entered for this account is invalid';
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        code =
            'There have been too many requests sent from this device. Please try again later.';
        break;
      case 'ERROR_INVALID_EMAIL':
        code =
            'The email address is badly formatted.';
        break;
      default:
        code = e.message;
        break;
    }
  }


}