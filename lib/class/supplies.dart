import 'package:firebase_database/firebase_database.dart';
import 'FirebaseDatabase.dart';

class Supplies { 

  final String suppliesID;
  final String companyName;
  final String contactPhone;
  final String email;
  final String address;
  final String city;
  final String country;

  final   DatabaseReference suppliesRef = FirebaseData.database.reference().child('supplies');


  Supplies([this.suppliesID, this.companyName, this.contactPhone, this.email, this.address, this.city, this.country]) {
    handleSubmit();
  }

  void handleSubmit() async {
    print(toJson());
    await suppliesRef.push().set(toJson());
  }

  Supplies.fromSnapshot( DataSnapshot snapshot)
       : suppliesID       = snapshot.key,
         companyName      = snapshot.value["companyName"],
         contactPhone     = snapshot.value["contactPhone"],
         email            = snapshot.value["email"],
         address          = snapshot.value["address"],
         city             = snapshot.value["city"],
         country          = snapshot.value["country"];

  toJson() {
    return {
        "companyName"  : companyName,
        "contactPhone" : contactPhone,
        "email"        : email,
        "address"      : address,
        "city"         : city,
        "country"      : country
    };
  }

}