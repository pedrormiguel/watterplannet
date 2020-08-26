import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/ordenes/order.dart';
import 'package:watterplannet/class/ordenes/orderDetail.dart';
import 'package:watterplannet/class/ordenes/orderDetailProduct.dart';
import 'package:watterplannet/services/Auth.dart';
import 'package:watterplannet/utils/FoldingCell/FoldingWidget.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: StreamBuilder(
        stream: Order.orderRef
            .orderByChild("consumerID")
            .equalTo(Authentication.result.user.uid)
            .onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          var grade = snapshot.connectionState.toString();

          switch (grade) 
          {
            case "ConnectionState.active":
              Map<dynamic, dynamic> values =
                  snapshot.data.snapshot.value != null
                      ? snapshot.data.snapshot.value
                      : Map<dynamic, dynamic>();

              return wrapperWidget(values); // Lista de Ordenes
              break;

            case "ConnectionState.waiting":
            default:
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ));
              break;
          }
        },
      ),
    );
  }

  Widget wrapperWidget(Map<dynamic, dynamic> values) {
    return FutureBuilder<List<Order>>(
        future: Order.getListOrderConsumer(values),
        builder: (context, snapshot) 
        {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) 
            {
              return cardCustom(snapshot.data);
            } else 

            {
              return Center
              (
                  child: Container
              (
                padding: EdgeInsets.only(right: 10),
                child: Transform.rotate(
                  angle: -(3.5) / 4,
                  child: AutoSizeText(
                    "No tiene Ordenes".toUpperCase(),
                    textScaleFactor: 3,
                    maxLines: 1,
                    style: TextStyle(color: Colors.red[200]),
                  ),
                ),
              ));
            }
          } else if (snapshot.hasError) {
            return Text("Error");
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  Widget cardCustom(List<Order> elements) {
    return ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
                width: double.infinity,
                child:
                    Flex(
                      
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.max, children: <Widget>
                [
                  FutureBuilder<List<OrderDetail>>
                  (
                    future: Order.getListOrderDetail
                    (
                        elements.elementAt(index).orderIDOrderDetailId),
                        
                    builder: (context, snapshot) 
                    {
                      if (snapshot.hasData) 
                      {
                        List<Widget> toShow = List<Widget>();

                        snapshot.data.forEach((element) 
                        {
                            toShow.add
                            ( 
                                    FoldingCellSimpleDemo
                                    (
                                        id: elements.elementAt(index).orderID,
                                        address:
                                            elements.elementAt(index).orderShipToAddres,
                                        dateOfOrder: elements
                                            .elementAt(index)
                                            .getDateFormated()
                                            .toUpperCase(),
                                        statusOrder: elements.elementAt(index).orderStatus,
                                        changeToNotShowOrder: elements
                                            .elementAt(index)
                                            .changeStatusToNotShowOrder,
                                        orderDetailProduct: element.orderDetailProducts,
                                    )
                            );
                        });

                        return Column(children: toShow);
                      } else if (snapshot.hasError) 
                      {
                        print(snapshot.error);
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ])),
          );
        });
  }

  Widget orderDetailsProdutcs(OrderDetailProduct element) {
    return Container(
      width: double.infinity * 0.80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.check_box, size: 50),
              title: Text(element.nameProduct,
                  style: TextStyle(color: Colors.pink)),
              subtitle: Text("Cantidad : ${element.amountOfUnits}",
                  style: TextStyle(color: Colors.pink)),
            ),
            ButtonBar(
              children: <Widget>[
                Text(
                    "SubTotal ${element.getTotalProductFormated()}"
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
