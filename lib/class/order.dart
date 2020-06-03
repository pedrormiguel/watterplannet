import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/Enums/statusOfOrders.dart';
import 'package:watterplannet/class/Enums/statusToShow.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';
import 'package:watterplannet/class/orderDetail.dart';
import 'package:watterplannet/utils/idGenerators.dart';

import 'orderDetailProduct.dart';

class Order {

  String orderID;
  String orderIDOrderDetailId;
  final String userID;
  
  DateTime orderDateBuy;
  String orderShipToAddres;

  OrderDetail orderDetail;
  List<OrderDetailProduct> orderDetailProduct;

  String orderStatus;
  String statusToShowOrder;
  // String orderShipperId;

  static DatabaseReference orderRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentOrder);

  Order({this.userID, this.orderShipToAddres, this.orderDetailProduct}) 
  {
    this.orderDateBuy = DateTime.now();
    this.orderIDOrderDetailId = IdGenerators.createCryptoRandomString();
    this.orderStatus = StatusOfOrders.orderStatus[1];
    this.statusToShowOrder = StatusToShowOrder.statusActive;

    this.orderDetail = new OrderDetail(
        orderIDOrderDetailId: this.orderIDOrderDetailId,
        orderDetailProduct: this.orderDetailProduct);
        
    handleSubmit();
  }

  Future<void> handleSubmit() async {
    print(toJson());
    await orderRef.push().set(toJson());
  }

  //TODO agregar directamente
  Order.fromMap(dynamic value)
      : orderIDOrderDetailId = value["orderIDOrderDetailId"],
        userID = value["userID"],
        orderDateBuy = DateTime.parse(value["orderDateBuy"]),
        orderStatus = value["orderStatus"],
        statusToShowOrder = value["statusToShowOrder"],
        orderShipToAddres = value["orderShipToAddres"];

  Order.fromSnapshot(DataSnapshot snapshot)
      : orderID = snapshot.key,
        orderIDOrderDetailId = snapshot.value["orderIDOrderDetailId"],
        userID = snapshot.value["userID"],
        orderDateBuy = snapshot.value["orderDateBuy"],
        orderStatus = snapshot.value["orderStatus"],
        statusToShowOrder = snapshot.value["statusToShowOrder"],
        orderShipToAddres = snapshot.value["orderShipToAddres"];

  static Future<Order> getOrder(String key, dynamic value) async {
    var currentOrder = Order.fromMap(value);

    currentOrder.orderID = key;

    return currentOrder;
  }

  static Future<List<Order>> getListOrderUser(
      Map<dynamic, dynamic> values) async {
    List<Order> orderList = new List<Order>();

    values.forEach((key, value) async {
      var p = await getOrder(key, value);

      if (p.statusToShowOrder == StatusToShowOrder.statusActive)
        orderList.add(p);
    });

    return orderList;
  }

  static Future<List<OrderDetail>> getListOrderDetail(String id) async {
    
    List<OrderDetail> orderDetailList = new List<OrderDetail>();

    DataSnapshot p = await OrderDetail.orderDetailRef
        .orderByChild('orderIDOrderDetailId')
        .equalTo(id)
        .once();

      var c =  convertFromSnapshot(p.value, id);

     orderDetailList.add
     (
        c
     );


    return orderDetailList;
  }

  String getDateFormated() 
  {
    return "Fecha de Orden ${this.orderDateBuy.day}/${this.orderDateBuy.month}/${this.orderDateBuy.year} ";
  }

  Future<void> changeStatusToNotShowOrder(String id) async {
    var toModify = {"statusToShowOrder": StatusToShowOrder.statusNoActive};

    return await orderRef.child(id).update(toModify);
  }

  static OrderDetail convertFromSnapshot(Map elements, String id) {

    OrderDetail orderDetails = new OrderDetail.home();
    orderDetails.orderDetailProduct = new List<OrderDetailProduct>();
    orderDetails.orderIDOrderDetailId = id;

   // corregir id

    // orderDetails.orderIDOrderDetailId

     elements.forEach((key, value) 
      {
         orderDetails.orderDetailID = key; 
         
         

          var json = value["products"];
          print(json[0]);

         

         for(int i =0; i < json.length; i++)
         {
             Map p = json[i];
             
            p.forEach((keyp, orderDetailProductorder) {


             double unipriceDouble = double.parse( orderDetailProductorder["unitPrice"].toString() );

              orderDetails.orderDetailProduct.add
                  (
                      OrderDetailProduct(
                        amountOfUnits: orderDetailProductorder["amountOfUnits"],
                        nameProduct:   orderDetailProductorder["nameProduct"],
                        unitPrice:  unipriceDouble    ,
                        productID: keyp
                      )
                  );

             });
         }

      });
      
     return orderDetails;
  }

  toJson() {
    return 
    {
      "orderIDOrderDetailId": orderIDOrderDetailId,
      "userID": userID,
      "orderDateBuy": orderDateBuy.toString(),
      "orderShipToAddres": orderShipToAddres,
      "orderStatus": orderStatus,
      "statusToShowOrder": statusToShowOrder
    };
  }
}
