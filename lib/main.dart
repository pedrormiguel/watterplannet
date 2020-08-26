import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/routes/routes.dart';

void main() =>
    runApp(DevicePreview(enabled: false, builder: (conte) => MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'WatterPlannet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: getApplicationRoute(),
    );
  }
}
