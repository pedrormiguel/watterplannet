import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/Enums/statusOfOrders.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';
import 'package:watterplannet/class/orderDetail.dart';
import 'package:watterplannet/utils/idGenerators.dart';

import 'orderDetailProduct.dart';

class Order {

   String   orderID;
   String   orderIDOrderDetailId;
   final String   userID;
   DateTime orderDateBuy;
   String   orderShipToAddres;

   OrderDetail orderDetail;
   List<OrderDetailProduct> orderDetailProduct;


  String orderStatus;
  // String orderShipperId;

   static DatabaseReference orderRef = FirebaseData.database.reference () .child(NameDocumentsTable.tableDocumentOrder);

  Order({this.userID, this.orderShipToAddres,this.orderDetailProduct}){

     this.orderDateBuy = DateTime.now();
     this.orderIDOrderDetailId = IdGenerators.createCryptoRandomString();
     this.orderStatus = StatusOfOrders.orderStatus[1];

     this.orderDetail = new OrderDetail(orderIDOrderDetailId: this.orderIDOrderDetailId,orderDetailProduct: this.orderDetailProduct);
    handleSubmit();
  }

  Future<void> handleSubmit() async {
    print( toJson() );
    await orderRef.push().set( toJson() );
  }

  //TODO agregar directamente 
  Order.fromMap(dynamic value)
    :    orderIDOrderDetailId   = value["orderIDOrderDetailId"],
         userID                 = value["userID"],
         orderDateBuy           = DateTime.parse(value["orderDateBuy"]),
         orderStatus            = value["orderStatus"],
         orderShipToAddres      = value["orderShipToAddres"];

  Order.fromSnapshot( DataSnapshot snapshot)
       : orderID                = snapshot.key,
         orderIDOrderDetailId   = snapshot.value["orderIDOrderDetailId"],
         userID                 = snapshot.value["userID"],
         orderDateBuy           = snapshot.value["orderDateBuy"],
         orderStatus            = snapshot.value["orderStatus"],
         orderShipToAddres      = snapshot.value["orderShipToAddres"];

  static Future<Order> getOrder(String key, dynamic value) async {

      var currentOrder = Order.fromMap(value);

      currentOrder.orderID = key;

      return currentOrder;
  }

  static Future< List<Order>  > getListOrderUser(Map<dynamic, dynamic> values) async {

    List<Order> orderList = new List<Order>();

    values.forEach((key, value) async {

      var p = await getOrder(key, value );

      orderList.add(p);
     });

    return orderList;
  }

  String getDateFormated()
  {
    return "Fecha de Orden ${this.orderDateBuy.day}/${this.orderDateBuy.month}/${this.orderDateBuy.year} ";
  }

  toJson() 
  {
    return 
    {
       "orderIDOrderDetailId"   :orderIDOrderDetailId,
        "userID"                : userID,
        "orderDateBuy"          : orderDateBuy.toString(),
        "orderShipToAddres"     : orderShipToAddres,
        "orderStatus"           : orderStatus
    };
  }

}