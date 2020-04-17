import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/Enums/statusOfOrders.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class Order {

  final String   orderID;
  final String   userID;
  final DateTime orderDateBuy;
  final String   orderShipToAddres;

  String orderStatus;
  // String orderShipperId;

  final DatabaseReference orderRef = FirebaseData.database.reference () .child(NameDocumentsTable.tableDocumentOrder);

  Order({this.orderID, this.userID, this.orderDateBuy, this.orderShipToAddres}){
     this.orderStatus = StatusOfOrders.orderStatus[1];
      handleSubmit();
  }

  void handleSubmit() async {
    print( toJson() );
    await orderRef.push().set(toJson());
  }

  Order.fromSnapshot( DataSnapshot snapshot)
       : orderID            = snapshot.key,
         userID             = snapshot.value["userID"],
         orderDateBuy       = snapshot.value["orderDateBuy"],
         orderShipToAddres  = snapshot.value["orderShipToAddres"];



  toJson() {
    return {
        "userID"            : userID,
        "orderDateBuy"      : orderDateBuy,
        "orderShipToAddres" : orderShipToAddres
    };
  }

}