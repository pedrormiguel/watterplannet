import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/class/supplies.dart';

class Perfil {
  static Supplies supplies;
  static List<Product> listSuppliesProduct;

  FirebaseDatabase database = FirebaseDatabase.instance;

  static DatabaseReference productRefSupplie = FirebaseData.database
      .reference()
      .child('product')
     .orderByChild("suppliesID")
     .equalTo("0");
  //.equalTo(_supplies.keyAccountUID)

  static DatabaseReference supplieRef = FirebaseData.database
      .reference()
      .child("supplies")
      .orderByChild("email")
      .equalTo(supplies.email);

   

}
