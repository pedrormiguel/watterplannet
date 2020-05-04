import 'package:flutter/material.dart';
import 'package:watterplannet/screen/authentication/login.dart';
import 'package:watterplannet/screen/home/home_page.dart';
import 'package:watterplannet/screen/home/main_page.dart';
import 'package:watterplannet/screen/home/product_detail.dart';
import 'package:watterplannet/screen/home/shopping_cart_page.dart';
import 'package:watterplannet/screen/wrapper.dart';

Map<String, WidgetBuilder> getApplicationRoute() {

    return <String, WidgetBuilder> {

      '/':            (BuildContext context) => Login()        ,
      'home'        : (BuildContext context) => HomePage()  ,
      'detail'      : (BuildContext context) => ProductDetailPage(),
      'mainPage'    : (BuildContext context) => MainPage(),
      'wrapper'     : (BuildContext context) => Wrapper(),
      'shopingCart' : (BuildContext context ) => ShopingCartPage()
    };
}