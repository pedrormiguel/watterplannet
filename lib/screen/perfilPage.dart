import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/screen/homeUser/main_page.dart';
import 'package:watterplannet/utils/circleImage.dart';

import 'homeBussines/mainPageBussines.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();

  User user = MainPage.user == null ? MainPageBussines.user : MainPage.user;
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Configuracion"),
        ),
        body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width * .90,
              //decoration: BoxDecoration(border: Border.all()),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AutoSizeText(
                      "Perfil de Usuario".toUpperCase(),
                      maxFontSize: 50,
                      minFontSize: 25,
                      style: TextStyle(),
                    ),
                    CircleImage(
                        height: 150,
                        width: 150,
                        imageUrl: widget.user.imageUser),
                    GFListTile(
                        titleText: "Nombre",
                        subtitleText:widget.user.getName(),
                        icon: Icon(Icons.perm_contact_calendar)),
                    GFListTile(
                        titleText: "Correo",
                        subtitleText:widget.user.email,
                        icon: Icon(Icons.email)),
                    GFListTile(
                        titleText: "Telefono",
                        subtitleText:widget.user.phoneNumber,
                        icon: Icon(Icons.phone)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        GFButton(
                          color: Color.fromRGBO(121, 173, 220, 1),
                          onPressed: () => {},
                          text: "ACTUALIZAR",
                        ),
                        GFButton(
                          color: Color.fromRGBO(255, 152, 159, 1),
                          onPressed: () => {},
                          text: "CAMBIAR PASSWORD",
                        )
                      ],
                    )
                  ])),
        ));
  }
}
