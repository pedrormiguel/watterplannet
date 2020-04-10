import 'package:firebase_database/firebase_database.dart';

import 'FirebaseDatabase.dart';

class User  {

  //Personal Information
  String key;
  String name;
  String lastName;

  //Account Information
  String userName;
  String password;
  String email;
  bool   isSuperAdmin;

  DatabaseReference userRef = FirebaseData.database.reference().child('user');

  User({this.name,this.lastName,this.userName,this.password,this.email,this.isSuperAdmin});


  void handleSubmit(User userFromForm){
    userRef.push().set(userFromForm.toJson());
  }

  User.fromSnapshot( DataSnapshot snapshot)
       : key          = snapshot.key,
         name         = snapshot.value["name"],
         lastName     = snapshot.value["lastName"],
         userName     = snapshot.value["userName"],
         password     = snapshot.value["password"],
         email        = snapshot.value["email"],
         isSuperAdmin = snapshot.value["isSuperAdmin"];

  toJson(){
    return {
        "name"         : name,
        "lastName"     : lastName,
        "userName"     : userName,
        "password"     : password,
        "email"        : email,
        "isSuperAdmin" : isSuperAdmin
    };
  }


}


/* 

class Item {
  String key;
  String title;
  String body;

  Item(this.title, this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        body = snapshot.value["body"];

  toJson() {
    return {
      "title": title,
      "body": body,
    };
  }
}

*/