import 'package:flutter/material.dart';
import 'package:watterplannet/screen/authentication/login.dart';
import 'package:watterplannet/screen/camera.dart';
import 'package:watterplannet/screen/homeBussines/Formulario_Screen/formularioProductoActualizar.dart';
import 'package:watterplannet/screen/homeBussines/Formulario_Screen/formularioProductoCrear.dart';
import 'package:watterplannet/screen/homeBussines/mainPageBussines.dart';
import 'package:watterplannet/screen/homeBussines/ordenes.dart';
import 'package:watterplannet/screen/homeUser/home_page.dart';
import 'package:watterplannet/screen/homeUser/main_page.dart';
import 'package:watterplannet/screen/homeUser/product_detail.dart';
import 'package:watterplannet/screen/homeUser/shopping_cart_page.dart';
import 'package:watterplannet/screen/perfilPage.dart';

Map<String, WidgetBuilder> getApplicationRoute() {

    return <String, WidgetBuilder> {

      '/':            (BuildContext context) => Login()        ,
      'home'        : (BuildContext context) => HomePage()  ,
      'detail'      : (BuildContext context) => ProductDetailPage(),
      'mainPage'    : (BuildContext context) => MainPage("WatterPlannet"),
      'shopingCart' : (BuildContext context ) => ShopingCartPage("Carrito de Compra"),
      'perfil'      : (BuildContext context) => PerfilPage(),

      'ordenes'     : (BuildContext context) => Ordenes(),


      'mainPageBussines'     : (BuildContext context) => MainPageBussines(),
      'formCreateProduct'    : (BuildContext context) => FormularioProductoCrear(),
      'formUpdateProduct'    : (BuildContext context) => FormularioProductoActualizar(),

      'camera' :  (BuildContext context) => SelectePickerPhoto()
    };
}