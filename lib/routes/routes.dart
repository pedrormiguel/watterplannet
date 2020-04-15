import 'package:flutter/material.dart';
import 'package:watterplannet/screen/authentication/login.dart';
import 'package:watterplannet/screen/home/home_page.dart';
import 'package:watterplannet/screen/wrapper.dart';

Map<String, WidgetBuilder> getApplicationRoute() {

    return <String, WidgetBuilder> {

      '/': (BuildContext context) => Login()        ,
      'home': (BuildContext context) => HomePage()  ,
      'wrapper': (BuildContext context) => Wrapper()

    };
}