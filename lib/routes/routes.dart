import 'package:flutter/material.dart';
import 'package:watterplannet/screen/login.dart';

Map<String, WidgetBuilder> getApplicationRoute() {

    return <String, WidgetBuilder> {

      '/': (BuildContext context) => Login()

    };
}