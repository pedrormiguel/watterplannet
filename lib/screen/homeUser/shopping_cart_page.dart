import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/order.dart';
import 'package:watterplannet/class/orderDetailProduct.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/homeUser/title_text.dart';
import 'package:watterplannet/services/Auth.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';
import 'package:watterplannet/utils/FlushBart.dart';

class ShopingCartPage extends StatefulWidget {
  const ShopingCartPage({Key key}) : super(key: key);

  @override
  _ShopingCartPageState createState() => _ShopingCartPageState();
}

class _ShopingCartPageState extends State<ShopingCartPage> {
  Widget _cartItems(BuildContext context) {
    return Column(
        children: AppData.cartList.itemSelect
            .map((e) => _item(e.product, e.cuantity, e.positionList, context))
            .toList());
  }

  Widget _item(
      Product model, int cantidad, int position, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3),
      height: MediaQuery.of(context).size.height * .15,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    constraints: BoxConstraints.expand(),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(model.image))))
              ],
            ),
          ),
          Expanded(
              child: ListTile(
            title: AutoSizeText(
              model.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              maxFontSize: 12,
              minFontSize: 10,
            ),
            subtitle: Row(
              children: <Widget>[
                TitleText(
                  text: '\$ ',
                  color: LightColor.red,
                  fontSize: 12,
                ),
                TitleText(
                  text: model.price.toString(),
                  fontSize: 14,
                ),
              ],
            ),
            trailing: Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(150),
                  borderRadius: BorderRadius.circular(10)),
              child: TitleText(
                text: '$cantidad',
                fontSize: 12,
              ),
            ),
          )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                color: Colors.blue,
                icon: new Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    AppData.cartList.itemSelect.elementAt(position).cuantity +=
                        1;
                  });
                },
              ),
              IconButton(
                color: Colors.red,
                icon: new Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (cantidad > 1)
                      AppData.cartList.itemSelect
                          .elementAt(position)
                          .cuantity -= 1;
                    else
                      AppData.cartList.itemSelect.removeAt(position);
                    for (var i = 0;
                        i < AppData.cartList.itemSelect.length;
                        i++) {
                      AppData.cartList.itemSelect.elementAt(i).positionList = i;
                    }
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${AppData.cartList.itemSelect.length} Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${getPrice()}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: completedBuy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'checkout'.toUpperCase(),
            color: LightColor.background,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  double getPrice() {
    double price = 0;

    AppData.cartList.itemSelect.forEach((x) {
      price += x.product.price * x.cuantity;
    });

    return price;
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
      //appBar: AppBar(),
        body: Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cartItems(context),
            Divider(
              thickness: 1,
              height: 50,
            ),
            _price(),
            SizedBox(height: 30),
            _submitButton(context),
          ],
        ),
      ),
    ));
  }

  void completedBuy() {
    if (AppData.cartList.itemSelect.length <= 0) 
    {
      FlusBar().getBar(
          context: context, message: 'Agrega algun producto al carrito.');

    } 
    else if(AppData.cartList.itemSelect != null)
    {
      List<OrderDetailProduct> orderDetailProducts = new List<OrderDetailProduct>();

      AppData.cartList.itemSelect.forEach((element) 
      {
        orderDetailProducts.add
        (

              new OrderDetailProduct
              (   
                  productID: element.product.productID,
                  nameProduct: element.product.name,
                  amountOfUnits: element.cuantity,
                  unitPrice: element.product.price
              )
        );

      });

      // TODO Dirreccion buscar direccion de cliente.

      new Order
          (
            userID: Authentication.uid,
            orderShipToAddres: "PRADO",
            orderDetailProduct: orderDetailProducts
          );

      setState(() 
      {
        AppData.cartList.itemSelect.clear();

      });

      FlusBar().getBar(context: context, message: 'Orden Completada.');

    }
  }
}
