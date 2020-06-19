import 'package:flutter/material.dart';
import 'package:watterplannet/screen/authentication/login.dart';
import 'package:watterplannet/screen/camera.dart';
import 'package:watterplannet/screen/homeBussines/formularioProductoActualizar.dart';
import 'package:watterplannet/screen/homeBussines/formularioProductoCrear.dart';
import 'package:watterplannet/screen/homeBussines/mainPageBussines.dart';
import 'package:watterplannet/screen/homeUser/home_page.dart';
import 'package:watterplannet/screen/homeUser/main_page.dart';
import 'package:watterplannet/screen/homeUser/product_detail.dart';
import 'package:watterplannet/screen/homeUser/shopping_cart_page.dart';

Map<String, WidgetBuilder> getApplicationRoute() {

    return <String, WidgetBuilder> {

      '/':            (BuildContext context) => Login()        ,
      'home'        : (BuildContext context) => HomePage()  ,
      'detail'      : (BuildContext context) => ProductDetailPage(),
      'mainPage'    : (BuildContext context) => MainPage(),
      'shopingCart' : (BuildContext context ) => ShopingCartPage(),


      'mainPageBussines'     : (BuildContext context) => MainPageBussines(),
      'formCreateProduct'    : (BuildContext context) => FormularioProductoCrear(),
      'formUpdateProduct'    : (BuildContext context) => FormularioProductoActualizar(),

      'camera' :  (BuildContext context) => SelectePickerPhoto()
    };
}