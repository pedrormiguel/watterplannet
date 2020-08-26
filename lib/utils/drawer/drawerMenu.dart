import 'package:flutter/material.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/utils/circleImage.dart';

import 'package:watterplannet/utils/drawer/drawerOptions.dart';

class DraweMenu extends StatelessWidget {

  final List<DrawerOptions> drawerOptions;  
  final User user;
  
  const DraweMenu({Key key, this.drawerOptions, this.user}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return drawer();
  }

Widget drawer() 
{
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          UserAccountsDrawerHeader(
            currentAccountPicture: CircleImage(width: 50,height: 50, imageUrl: user.imageUser,),
            accountEmail: Text( user.email     ),
            accountName: Text ( user.getName() ),
            decoration: BoxDecoration( color: Colors.blue),
          ),

          Column(

            children: drawerOptions

          )
          
        ],
      ),
    );
}


}

