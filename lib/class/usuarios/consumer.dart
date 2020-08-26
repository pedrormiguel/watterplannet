import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import '../FirebaseDatabase.dart';

class Consumer implements User {
  //Personal Information
  String consumerID;
  String name;
  String lastName;
  String phoneNumber;
  String address;
  String password;
  String imageUser;
  String email;

  DatabaseReference consumerRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentConsumer);

  Consumer(
      {this.name,
      this.imageUser,
      this.lastName,
      this.password,
      this.email,
      this.phoneNumber,
      this.address}) {
    handleSubmit();
  }

  Consumer.fromMap(
      {this.consumerID,
      this.name,
      this.lastName,
      this.password,
      this.email,
      this.phoneNumber,
      this.address});

  // TODO Arreglar error al momento de que falla pero aun crea cuenta.
  void handleSubmit() => consumerRef.push().set(toJson());

  Consumer.fromSnapshot(String key, DataSnapshot snapshot)
      : consumerID = snapshot.key,
        name = snapshot.value["name"],
        lastName = snapshot.value["lastName"],
        password = snapshot.value["password"],
        email = snapshot.value["email"],
        phoneNumber = snapshot.value["phoneNumber"],
        imageUser = snapshot.value["imageUser"],
        address = snapshot.value["address"];

  Consumer.fromLogin(String key, Map snapshot)
      : consumerID = key,
        name = snapshot["name"],
        lastName = snapshot["lastName"],
        password = snapshot["password"],
        email = snapshot["email"],
        phoneNumber = snapshot["phoneNumber"],
        imageUser = snapshot["imageUser"] == null
            ? "https://asociaciondenutriologia.org/img/default_user.png"
            : snapshot["imageUser"],
        address = snapshot["address"];

  Map<String, String> toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "password": password,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
      "imageUser": imageUser == null
          ? "https://asociaciondenutriologia.org/img/default_user.png"
          : imageUser
    };
  }

  String loggin() {
    return "mainPage";
  }

  @override
  String getName() => name;

  @override
  String getIdFromFireBase() => consumerID;
}
