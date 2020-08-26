import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class OrderDetailProduct {
  // final String orderDetailID;

  final String productID;
  final String nameProduct;
  final int amountOfUnits;
  final double unitPrice;
  final String urlImage;
  final String supplierID;

  final DatabaseReference orderDetailProductRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentOrderDetailProduct);

  OrderDetailProduct
  (
      {this.productID,
      this.supplierID,
      this.amountOfUnits,
      this.nameProduct,
      this.unitPrice,
      this.urlImage}
  );

  factory OrderDetailProduct.fromMap(Map json) => OrderDetailProduct(
        unitPrice:  double.parse( json["unitPrice"].toString() ) ,
        supplierID: json["supplierID"],
        nameProduct: json["nameProduct"],
        amountOfUnits: json["amountOfUnits"],
        urlImage: json["urlImage"],
      );

   

  // toJson() {
  //   return {
  //     "productID": productID,
  //     "nameProduct": nameProduct,
  //     "amountOfUnits": amountOfUnits,
  //     "unitPrice": unitPrice,
  //     "urlImage": urlImage
  //   };
  // }

  toJson() {
    return {
      supplierID: {
        "productID": productID,
        "nameProduct": nameProduct,
        "amountOfUnits": amountOfUnits,
        "unitPrice": unitPrice,
        "urlImage": urlImage
      }
    };
  }

  double getTotalProduct() {
    return amountOfUnits * unitPrice;
  }

  String getTotalProductFormated() {
    return NumberFormat.simpleCurrency().format(amountOfUnits * unitPrice);
  }

  String formatPrice(double price) =>
      NumberFormat.simpleCurrency().format(price);

  void handleSubmit() {
    orderDetailProductRef.push().set(toJson());
  }
}
