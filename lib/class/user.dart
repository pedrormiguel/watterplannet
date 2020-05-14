import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';

import 'FirebaseDatabase.dart';

class User  {

  //Personal Information
  String userID;
  String name;
  String lastName;
  String phoneNumber;
  String address;

  //Account Information
  //String userName;
  String password;
  String email;
  //bool   isSuperAdmin;

  DatabaseReference userRef = FirebaseData.database.reference().child( NameDocumentsTable.tableDocumentUser );

  User({this.name,this.lastName,this.password,this.email,this.phoneNumber,this.address}) {
    handleSubmit();
  }

   User.fromMap({this.userID,this.name,this.lastName,this.password,this.email,this.phoneNumber,this.address});


  void handleSubmit() async {
    print(toJson());
    await userRef.push().set(toJson()); // TODO Arreglar error al momento de que falla pero aun crea cuenta.
  }

  User.fromSnapshot( DataSnapshot snapshot)
       : userID       = snapshot.key,
         name         = snapshot.value["name"],
         lastName     = snapshot.value["lastName"],
         password     = snapshot.value["password"],
         email        = snapshot.value["email"],
         phoneNumber  = snapshot.value["phoneNumber"],
         address      = snapshot.value["address"];

  toJson(){
    return {
        "name"         : name,
        "lastName"     : lastName,
        //"userName"     : userName,
        "password"     : password,
        "email"        : email,
       // "isSuperAdmin" : isSuperAdmin,
        "phoneNumber"  : phoneNumber,
        "address"      : address
    };
  }


}