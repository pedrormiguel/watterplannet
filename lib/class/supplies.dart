import 'package:firebase_database/firebase_database.dart';
import 'FirebaseDatabase.dart';

class Supplies { 

  String suppliesID;
  final String keyAccountUID;
  final String companyName;
  final String contactPhone;
  final String email;
  final String password;
  final String address;
  final String city;


  final   DatabaseReference suppliesRef = FirebaseData.database.reference().child('supplies');


  Supplies({this.keyAccountUID, this.companyName, this.contactPhone, this.email, this.password, this.address, this.city}) {
    handleSubmit();
  }

  void handleSubmit() async {
    print(toJson());
    await suppliesRef.push().set(toJson());
  }

  Supplies.fromSnapshot( DataSnapshot snapshot )
       : suppliesID       = snapshot.key,
         keyAccountUID    = snapshot.value["keyAccountUID"],
         companyName      = snapshot.value["companyName"],
         contactPhone     = snapshot.value["contactPhone"],
         email            = snapshot.value["email"],
         password         = snapshot.value["password"],
         address          = snapshot.value["address"],
         city             = snapshot.value["city"];

  toJson() {
    return {
        "keyAccountUID": keyAccountUID,
        "companyName"  : companyName,
        "contactPhone" : contactPhone,
        "email"        : email,
        "password"     : password,
        "address"      : address,
        "city"         : city
      };
  }

}