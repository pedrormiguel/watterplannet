import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class OrderDetail {
        String orderDetailID;
  final String productID;
  final double amountOfUnits;
  final int    unitPrice;
  //      double total; TODO Pensar en la manera de calcular total.
  
  final DatabaseReference orderDetailRef = FirebaseData.database.reference () .child( NameDocumentsTable.tableDocumentOrderDetail ); 

  OrderDetail({this.productID, this.amountOfUnits, this.unitPrice}){
      handleSubmit();
  }

  void handleSubmit() async {
    print( toJson() );
    await orderDetailRef.push().set(toJson());
  }

  OrderDetail.fromSnapshot( DataSnapshot snapshot)
       : orderDetailID      = snapshot.key,
         productID          = snapshot.value["productID"],
         amountOfUnits      = snapshot.value["amountOfUnits"],
         unitPrice          = snapshot.value["unitPrice"];

  toJson() {
    return {
        "productID"         : productID,
        "amountOfUnits"     : amountOfUnits,
        "unitPrice"         : unitPrice
    };
  }
}