import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class OrderDetailProduct {

  // final String orderDetailID;

  final String productID;
  final String nameProduct;
  final int amountOfUnits;
  final double unitPrice;

  final DatabaseReference orderDetailProductRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentOrderDetailProduct);

  OrderDetailProduct(
      {
      this.productID,
      this.amountOfUnits,
      this.nameProduct,
      this.unitPrice});

  toJson() 
  {
    return 
    {
      "productID"    :  productID,
      "nameProduct"  : nameProduct,
      "amountOfUnits": amountOfUnits,
      "unitPrice"    : unitPrice
    };
  }

  double getTotalProduct(){
    return amountOfUnits * unitPrice;
  }

  void handleSubmit() {
    orderDetailProductRef.push().set(toJson());
  }
}
