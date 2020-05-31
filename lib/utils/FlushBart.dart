
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlusBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBar(),
    );
  }


 Widget getBar({BuildContext context,String title="Notification",String message}) {

    return Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      title: title,
      message: message,
      backgroundGradient: LinearGradient(colors: [Colors.teal, Colors.red],),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);

 }
}