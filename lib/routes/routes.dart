import 'package:flutter/material.dart';
import 'package:watterplannet/screen/authentication/login.dart';
import 'package:watterplannet/screen/wrapper.dart';

Map<String, WidgetBuilder> getApplicationRoute() {

    return <String, WidgetBuilder> {

      '/': (BuildContext context) => Login(),
      'wrapper': (BuildContext context) => Wrapper()

    };
}