import 'package:flutter/material.dart';

class DrawerOptions extends StatelessWidget {

  final String title;
  final Icon icon;
  final Function function;


  const DrawerOptions({Key key, this.title, this.icon, this.function}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return drawerOptions(title,icon,function);
  }

  Widget drawerOptions(String title, Icon icon, Function function) {
    return ListTile(
      leading: new IconButton(
          icon: icon, color: Colors.black, onPressed: () => null),
      title: Text(title),
      onTap: function,
    );
  }
} 

