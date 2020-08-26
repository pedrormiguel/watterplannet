import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import '../FirebaseDatabase.dart';

class Supplier implements User {
  String supplierID;
  List<Product> listProduct;

  final String keyAccountUID;
  final String companyName;
  final String phoneNumber;
  final String email;
  final String password;
  final String address;
  String imageUser;
  final String city;

  final DatabaseReference suppliesRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentSupplies);

  Supplier(
      {this.keyAccountUID,
      this.companyName,
      this.phoneNumber,
      this.email,
      this.password,
      this.address,
      this.imageUser,
      this.city}) {
    handleSubmit();
  }

  Supplier.fromMap(
      {this.supplierID,
      this.imageUser,
      this.keyAccountUID,
      this.companyName,
      this.phoneNumber,
      this.email,
      this.password,
      this.address,
      this.city});

  void handleSubmit() => suppliesRef.push().set(toJson());

  Supplier.fromSnapshot(DataSnapshot snapshot)
      : supplierID = snapshot.key,
        keyAccountUID = snapshot.value["keyAccountUID"],
        companyName = snapshot.value["companyName"],
        phoneNumber = snapshot.value["phoneNumber"],
        email = snapshot.value["email"],
        password = snapshot.value["password"],
        address = snapshot.value["address"],
        imageUser = snapshot.value["imageUser"],
        city = snapshot.value["city"];

  @override
  Map<String, String> toJson() {
    return {
      "keyAccountUID": keyAccountUID,
      "companyName": companyName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "address": address,
      "imageUser": imageUser == null
          ? "https://asociaciondenutriologia.org/img/default_user.png"
          : imageUser,
      "city": city
    };
  }

  @override
  String loggin() {
    return "mainPageBussines";
  }

  @override
  set address(String _address) => address;

  @override
  set email(String _address) => email;

  @override
  String getName() => this.companyName;

  @override
  set phoneNumber(String _phoneNumber) {}

  @override
  String getIdFromFireBase() => supplierID;
}
