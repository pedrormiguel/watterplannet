import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';
import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/ordenes/orderDetailProduct.dart';

class OrderDetail {
  String orderDetailID;
  String orderIDOrderDetailId;

  List<OrderDetailProduct> orderDetailProducts;

  static DatabaseReference orderDetailRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentOrderDetail);

  OrderDetail({this.orderIDOrderDetailId}) {
    this.orderDetailProducts = List<OrderDetailProduct>();

    AppData.cartList.itemSelect.forEach((element) {
      element.product.updateStock(element.cuantity);

      orderDetailProducts.add(new OrderDetailProduct(
          supplierID: element.product.supplierID,
          productID: element.product.productID,
          nameProduct: element.product.name,
          amountOfUnits: element.cuantity,
          unitPrice: element.product.price,
          urlImage: element.product.image));
    });

    handleSubmit();
  }

  OrderDetail.home();

  List<String> getIdProvider() {
    List<String> output = [];

    this.orderDetailProducts.forEach((element) {
      output.add(element.supplierID);
    });

    return output;
  }

  Future<void> handleSubmit() async =>
      await orderDetailRef.push().set(toJson());

  toJson() {
    return {
      "orderIDOrderDetailId": orderIDOrderDetailId,
      "products": toJsonProductOrder()
    };
  }

  toJsonProductOrder() {
    var p = List<Map<String, dynamic>>();

    orderDetailProducts.forEach((element) {
      p.add({
        "supplierID": element.supplierID,
        "nameProduct": element.nameProduct,
        "amountOfUnits": element.amountOfUnits,
        "unitPrice": element.unitPrice,
        "urlImage": element.urlImage
      });

      //   p.add
      //   (
      //     {
      //       element.supplierID:
      //       {
      //         "nameProduct": element.nameProduct,
      //         "amountOfUnits": element.amountOfUnits,
      //         "unitPrice": element.unitPrice,
      //         "urlImage": element.urlImage
      //       }
      //     }
      //   );
      // });
    });

    return p;
  }
}
