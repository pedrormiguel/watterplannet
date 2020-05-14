import 'package:flutter/material.dart';

import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/homeUser/title_text.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';

class ShopingCartPage extends StatelessWidget {
  const ShopingCartPage({Key key}) : super(key: key);

  Widget _cartItems(BuildContext context) {
    return Column(
  
      children: AppData.cartList.map((x) => _item(x,context)).toList());
  }

  Widget _item(Product model, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      child: Row(
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
                  title: TitleText(
                    text: model.name,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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
                    width: 35, //TODO
                    height: 35,//TODO
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      //text: 'x${model.productID}',
                      text: 1.toString(), //TODO 
                      fontSize: 12,
                    
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${AppData.cartList.length} Items',
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
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Next',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  double getPrice() {
    double price = 0;
    AppData.cartList.forEach((x) {
      price += x.price * 2 ; // TODO Verificar calculo que no sea fijo
    });
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold ( 
      body : Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        
        child: Column(
          children: <Widget>[
            _cartItems(context),
            Divider(
              thickness: 1,
              height: 70,
            ),
            _price(),
            SizedBox(height: 30),
            _submitButton(context),
          ],
        ),
      ),
    ));
  }
}
