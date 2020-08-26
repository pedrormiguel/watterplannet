import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/Enums/statusOfOrders.dart';
import 'package:watterplannet/class/Enums/statusToShow.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';
import 'package:watterplannet/class/ordenes/orderDetail.dart';
import 'package:watterplannet/utils/idGenerators.dart';

import 'orderDetailProduct.dart';

class Order {
  String orderID;
  String orderIDOrderDetailId;
  final String consumerID;

  DateTime orderDateBuy;
  String orderShipToAddres;
  OrderDetail orderDetail;
  String orderStatus;
  String statusToShowOrder;

  List<String> providersID;
  // String orderShipperId;

  static DatabaseReference orderRef = FirebaseData.database
      .reference()
      .child(NameDocumentsTable.tableDocumentOrder);

  Order({this.consumerID, this.orderShipToAddres}) {
    this.orderDateBuy = DateTime.now();
    this.orderIDOrderDetailId = IdGenerators.createCryptoRandomString();
    this.orderStatus = StatusOfOrders.statusOfOrderPendiente;
    this.statusToShowOrder = StatusToShowOrder.statusActive;

    this.orderDetail =
        new OrderDetail(orderIDOrderDetailId: this.orderIDOrderDetailId);

    this.providersID = this.orderDetail.getIdProvider();

    handleSubmit();
  }

  Future<void> handleSubmit() async => await orderRef.push().set(toJson());

  //TODO agregar directamente
  Order.fromMap(Map<String, dynamic> value)
      : orderIDOrderDetailId = value["orderIDOrderDetailId"],
        consumerID = value["consumerID"],
        orderDateBuy = DateTime.parse(value["orderDateBuy"]),
        orderStatus = value["orderStatus"],
        statusToShowOrder = value["statusToShowOrder"],
        providersID = List<String>.from(value["providersID"]),
        orderShipToAddres = value["orderShipToAddres"];

  Order.fromDynamic(dynamic key, dynamic value)
      : orderIDOrderDetailId = value["orderIDOrderDetailId"],
        orderID = key,
        consumerID = value["consumerID"],
        orderDateBuy = DateTime.parse(value["orderDateBuy"]),
        orderStatus = value["orderStatus"],
        statusToShowOrder = value["statusToShowOrder"],
        providersID = List<String>.from(value["providersID"]),
        orderShipToAddres = value["orderShipToAddres"];

  Order.fromSnapshot(DataSnapshot snapshot)
      : orderID = snapshot.key,
        orderIDOrderDetailId = snapshot.value["orderIDOrderDetailId"],
        consumerID = snapshot.value["consumerID"],
        orderDateBuy = snapshot.value["orderDateBuy"],
        orderStatus = snapshot.value["orderStatus"],
        statusToShowOrder = snapshot.value["statusToShowOrder"],
        orderShipToAddres = snapshot.value["orderShipToAddres"];

  static Future<Order> getOrder(String key, Map<dynamic, dynamic> value) async {
    var currentOrder = Order.fromMap(value);

    currentOrder.orderID = key;

    return currentOrder;
  }

  static Future<List<Order>> getListOrderConsumer(
      Map<dynamic, dynamic> values) async {
    List<Order> orderList = new List<Order>();

    values.forEach((key, value) async {
      //var p = await getOrder(key, value);
      var p = Order.fromDynamic(key, value);

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

    var c = convertFromSnapshot(p.value, id);

    orderDetailList.add(c);

    return orderDetailList;
  }

  String getDateFormated() {
    return "Fecha de Orden ${this.orderDateBuy.day}/${this.orderDateBuy.month}/${this.orderDateBuy.year} ";
  }

  Future<void> changeStatusToNotShowOrder(String id) async {
    var toModify = {"statusToShowOrder": StatusToShowOrder.statusNoActive};

    return await orderRef.child(id).update(toModify);
  }

  Future<void> changeStatusOrder(String id, String orderStatus) async {
    var toModify = {"orderStatus": orderStatus};

    return await orderRef.child(id).update(toModify);
  }

  static OrderDetail convertFromSnapshot(Map elements, String id) {
    OrderDetail orderDetails = new OrderDetail.home();
    orderDetails.orderDetailProducts = new List<OrderDetailProduct>();
    orderDetails.orderIDOrderDetailId = id;

    elements.forEach((key, value) {
      orderDetails.orderDetailID = key;

      var json = value["products"];

      for (int i = 0; i < json.length; i++) {
        Map p = json[i];

        orderDetails.orderDetailProducts.add(OrderDetailProduct(
            supplierID: p["supplierID"],
            amountOfUnits: p["amountOfUnits"],
            nameProduct: p["nameProduct"],
            unitPrice: double.parse(p["unitPrice"].toString()),
            productID: "keyp",
            urlImage: p["urlImage"]));
      }
    });

    return orderDetails;
  }

  toJson() {
    return {
      "orderIDOrderDetailId": orderIDOrderDetailId,
      "consumerID": consumerID,
      "orderDateBuy": orderDateBuy.toString(),
      "orderShipToAddres": orderShipToAddres,
      "orderStatus": orderStatus,
      "statusToShowOrder": statusToShowOrder,
      "providersID": providersID
    };
  }
}
