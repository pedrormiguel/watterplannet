import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class ProductSupplier {
  final String productSupplierID;
  final String productID;
  final String supplierID;
  final DatabaseReference productSupplierRef = FirebaseData.database.reference () .child(NameDocumentsTable.tableDocumentProductSupplier);
  // final String nota; 

  // TODO integrar con la cuenta principal Product.

  ProductSupplier( {this.productSupplierID,this.productID, this.supplierID} ){
     handleSubmit();
  }

  void handleSubmit() async {
    print(toJson());
    await productSupplierRef.push().set(toJson());
  }

  ProductSupplier.fromSnapshot( DataSnapshot snapshot)
       : productSupplierID       = snapshot.key,
         productID      = snapshot.value["productID"],
         supplierID     = snapshot.value["supplierID"];


  toJson() {
    return {
        "productSupplierID" : productSupplierID,
        "productID"         : productID,
        "supplierID"        : supplierID
    };
  }


}
