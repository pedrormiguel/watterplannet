import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';
import 'package:watterplannet/class/orderDetailProduct.dart';

class OrderDetail {
  String orderDetailID;
  String orderIDOrderDetailId;

  List<OrderDetailProduct> orderDetailProduct;

   static DatabaseReference orderDetailRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentOrderDetail);

  OrderDetail({this.orderIDOrderDetailId,this.orderDetailProduct}) {
    handleSubmit();
  }

  OrderDetail.home();

  Future<void> handleSubmit() async =>
    await orderDetailRef.push().set(toJson());

  toJson() {
    return 
    {
      "orderIDOrderDetailId"  : orderIDOrderDetailId,
      "products" : toJsonProductOrder()
    };
  }

  toJsonProductOrder() {

    var p = List<Map<String, Map<String, dynamic>>>();

      orderDetailProduct.forEach((element) {
        p.add({
          element.productID: {
            "nameProduct"     : element.nameProduct,
            "amountOfUnits"   : element.amountOfUnits,
            "unitPrice"       : element.unitPrice
          }
        });
      });

      return p;
    
  }

}
