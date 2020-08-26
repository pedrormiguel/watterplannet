import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/ordenes/order.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/homeUser/title_text.dart';
import 'package:watterplannet/services/Auth.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';
import 'package:watterplannet/utils/FlushBart.dart';
import 'package:watterplannet/utils/Sizes/SizesConfi.dart';

class ShopingCartPage extends StatefulWidget {
  final String title;
  const ShopingCartPage(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  _ShopingCartPageState createState() => _ShopingCartPageState();
}

class _ShopingCartPageState extends State<ShopingCartPage> {
  Widget _cartItems(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 60,
      child: SingleChildScrollView(
        child: Column(
            //direction: Axis.vertical,
            children: AppData.cartList.itemSelect
                .map((e) =>
                    _item(e.product, e.cuantity, e.positionList, context))
                .toList()),
      ),
    );
  }

  Widget _item(
      Product model, int cantidad, int position, BuildContext context) {
    return Row(
      //direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 60,
          height: SizeConfig.blockSizeVertical * 20,
          child: GFListTile(
            avatar: Container(
                width: SizeConfig.blockSizeHorizontal * 20,
                height: SizeConfig.blockSizeVertical * 10,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(model.image)))),
            //shape: GFAvatarShape.square,

            titleText: model.name,
            subtitleText: model.price.toString(),
          ),
        ),
        IconButton(
            color: Colors.blue,
            icon: new Icon(Icons.add),
            onPressed: () => setState(() =>
                AppData.cartList.itemSelect.elementAt(position).cuantity += 1)),
        Container(
          width: 5,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: LightColor.lightGrey.withAlpha(150),
              borderRadius: BorderRadius.circular(10)),
          child: TitleText(text: '$cantidad', fontSize: 12),
        ),
        IconButton(
          color: Colors.red,
          icon: new Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (cantidad > 1)
                AppData.cartList.itemSelect.elementAt(position).cuantity -= 1;
              else
                AppData.cartList.itemSelect.removeAt(position);
              for (var i = 0; i < AppData.cartList.itemSelect.length; i++) {
                AppData.cartList.itemSelect.elementAt(i).positionList = i;
              }
            });
          },
        )
      ],
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
    SizeConfig().init(context);

    return Scaffold(
        body: Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 100,
      padding: AppTheme.padding,
      child: Column(
        //direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _cartItems(context),
          _price(),
          _submitButton(context),
        ],
      ),
    ));
  }

  Future<void> completedBuy() async {
    if (AppData.cartList.itemSelect.length <= 0) {
      FlusBar().getBar(
          context: context, message: 'Agrega algun producto al carrito.');
    } else if (AppData.cartList.itemSelect != null) 
    {

        Order
         (
            consumerID: Authentication.result.user.uid,
            orderShipToAddres: "PRADO" //Todo Arreglar direccion
         );

      setState(() => AppData.cartList.itemSelect.clear());

      FlusBar().getBar(context: context, message: 'Orden Completada.');
    }
  }
}
