import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:watterplannet/class/Enums/statusOfOrders.dart';
import 'package:watterplannet/class/ordenes/order.dart';
import 'package:watterplannet/class/ordenes/orderDetail.dart';
import 'package:watterplannet/class/ordenes/orderDetailProduct.dart';
import 'package:watterplannet/screen/homeBussines/mainPageBussines.dart';
import 'package:watterplannet/utils/FoldingCell/FoldingWidget.dart';
import 'package:watterplannet/utils/Sizes/SizesConfi.dart';

class Ordenes extends StatefulWidget {
  @override
  _OrdenesState createState() => _OrdenesState();
}

class _OrdenesState extends State<Ordenes> {
  var _value;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: GFAppBar(),
      body: StreamBuilder(
          stream: OrderDetail.orderDetailRef.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            var grade = snapshot.connectionState.toString();

            switch (grade) {
              case "ConnectionState.active":
                return orderWidget(); // Lista de Ordenes
                // return Container(
                //   child: BackButton(
                //     onPressed: () async {
                //       var p = await getListOrder();
                //       print(p.elementAt(0).orderDetail);
                //     },
                //   ),
                // );
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
          }),
    );
  }

  Widget orderWidget() => Container(
      height: SizeConfig.blockSizeVertical * 100,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: FutureBuilder<List<Order>>(
          future: getListOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState.toString() == "ConnectionState.done") {
              if (snapshot.requireData != null) {
                return orderProductsFolding(snapshot.data);
              } else
                return Text("No items");
            }

            //else if( snapshot.connectionState.toString() == "ConnectionState.waiting" || snapshot.connectionState.toString() == "ConnectionState.none"  )

            return Center(child: CircularProgressIndicator());
          }));

  Future<List<Order>> getListOrder() async {
    var keySuplier = MainPageBussines.user.getIdFromFireBase();

    List<Order> orders = [];

    var orderRef = await Order.orderRef.orderByChild("providersID").once();

    var ordenesMap = orderRef.value;

    ordenesMap.forEach((
      key,
      value,
    ) {
      var providersID = List<String>.from(value["providersID"]);

      if (providersID.contains(keySuplier))
        orders.add(Order.fromDynamic(key, value));
    });

    print(orders);

    return orders;
  }

  Future<List<Order>> getItemsOrder(List<Order> order) async {
    List<OrderDetailProduct> orderDetailProducts = [];
    var keySuplier = MainPageBussines.user.getIdFromFireBase();

    order.forEach((element) async {
      var orderDetailRef = await OrderDetail.orderDetailRef
          .orderByChild("orderIDOrderDetailId")
          .equalTo(element.orderIDOrderDetailId)
          .once();

      Map orderDetailMap = orderDetailRef.value;

      //TODO determinar elementos presents.

      orderDetailMap.forEach((key, value) {
        var orderDetailsProdu = value["products"];

        orderDetailProducts.clear();

        orderDetailsProdu.forEach((element) {
          if (element["supplierID"] == keySuplier)
            orderDetailProducts.add(OrderDetailProduct.fromMap(element));
        });

        var p = OrderDetail.home();
        p.orderDetailID = key;
        p.orderIDOrderDetailId = value["orderIDOrderDetailId"];
        p.orderDetailProducts = orderDetailProducts;

        var a = order.indexWhere((element) =>
            element.orderIDOrderDetailId == p.orderIDOrderDetailId);
        order.elementAt(a).orderDetail = p;
      });
    });

    return order;
  }

  Widget orderProducts(List<OrderDetailProduct> items) => Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => GFCard(
                  boxFit: BoxFit.cover,
                  image: Image.network(
                    items.elementAt(index).urlImage,
                    width: double.infinity,
                    height: 100,
                  ),
                  title: GFListTile(
                      title: Text(items.elementAt(index).nameProduct),
                      icon: GFIconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite_border),
                        type: GFButtonType.transparent,
                      )),
                  content:
                      Text(items.elementAt(index).getTotalProductFormated()),
                  buttonBar: GFButtonBar(
                    alignment: WrapAlignment.start,
                    children: <Widget>[
                      Center(
                        child: DropdownButton<String>(
                          items: [
                            DropdownMenuItem<String>(
                              child:
                                  Text(StatusOfOrders.statusOfOrderPendiente),
                              value: StatusOfOrders.statusOfOrderPendiente,
                            ),
                            DropdownMenuItem<String>(
                              child: Text(StatusOfOrders.statusOfOrderEnviado),
                              value: StatusOfOrders.statusOfOrderEnviado,
                            ),
                            DropdownMenuItem<String>(
                              child:
                                  Text(StatusOfOrders.statusOfOrderTerminado),
                              value: StatusOfOrders.statusOfOrderTerminado,
                            ),
                          ],
                          onChanged: (String value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          hint: Text('Estado de la Orden'),
                          value: _value,
                        ),
                      )
                    ],
                  ),
                )),
      );

  Widget orderProductsFolding(List<Order> items) {
    return FutureBuilder<List<Order>>(
        future: getItemsOrder(items),
        builder: (context, snapshot) {
          if (snapshot.connectionState.toString() == "ConnectionState.done") {
            return Container(
                height: SizeConfig.blockSizeVertical * 40,
                width: SizeConfig.blockSizeHorizontal * 20,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        FoldingCellSimpleDemo(
                          id: items[index].orderID,
                          address: items[index].orderShipToAddres,
                          dateOfOrder: items[index].getDateFormated(),
                          statusOrder: items[index].statusToShowOrder,
                          changeToNotShowOrder: () {},
                          orderDetailProduct:
                              items[index].orderDetail.orderDetailProducts,
                        ),
                        Center
                        (
                          child: DropdownButton<String>(
                            items: [
                              DropdownMenuItem<String>(
                                child:
                                    Text(StatusOfOrders.statusOfOrderPendiente),
                                value: StatusOfOrders.statusOfOrderPendiente,
                              ),
                              DropdownMenuItem<String>(
                                child:
                                    Text(StatusOfOrders.statusOfOrderEnviado),
                                value: StatusOfOrders.statusOfOrderEnviado,
                              ),
                              DropdownMenuItem<String>(
                                child:
                                    Text(StatusOfOrders.statusOfOrderTerminado),
                                value: StatusOfOrders.statusOfOrderTerminado,
                              ),
                            ],
                            onChanged: (String value) async 
                            {
                                await items[index].changeStatusOrder( items[index].orderID, value);
                                setState(() { });
                            },
                            hint: Text('Estado de la Orden'),
                            value: items[index].orderStatus,
                          ),
                        )
                      ]);
                    }));
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
