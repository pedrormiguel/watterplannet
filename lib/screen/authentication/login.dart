import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/Enums/nameDocumentsTable.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

import 'package:watterplannet/class/usuarios/supplier.dart';
import 'package:watterplannet/class/usuarios/consumer.dart';

import 'package:flutter/services.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/services/Auth.dart';
import 'package:watterplannet/utils/FlushBart.dart';
import 'package:watterplannet/utils/validators.dart';

class Login extends StatefulWidget {

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<Login> with TickerProviderStateMixin {

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>(); 
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpAsSupplierKey = GlobalKey<FormState>();

  FlusBar flusBar = FlusBar();


  String _email, _password, _address, _name, _lastName;
  String correo = "claro@o.com";

  String _companyName,
      _contactPhone,
      _emailSupplier,
      _passwordSupplier,
      _addressSuplier,
      _citySupplier;

  int _phoneNumber;

  BoxDecoration customBackgroundPicture = BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.05), BlendMode.dstATop),
        image: AssetImage('assets/backgroundLogin.jpg'), //TODO AGREGAR VARIABLE DE FONDO NO TEXTO
        fit: BoxFit.cover,
      ));

  Widget headerofPage(String title, String path) 
  {
    return Container(
      height: 140,
      padding: EdgeInsets.only(top: 25.0, bottom: 20),
      child: Center(
        child: Column(children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: Image.asset(path),
          ),
          SizedBox(
            height: 25,
          ),
          AutoSizeText(
            title.toUpperCase(),
            style: TextStyle(fontSize: 25),
          ),
        ]),
      ),
    );
  }

  String _loginEmail, _loginPassword;
  Authentication _auth = Authentication();

  @override
  void initState() 
  {
    super.initState();
  }

  BoxDecoration customBox = BoxDecoration(
    border: Border(
      bottom: BorderSide(
          color: Colors.redAccent, width: 0.5, style: BorderStyle.solid),
    ),
  );

  DecorationImage customImage = DecorationImage(
    colorFilter:
        new ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
    image: AssetImage('assets/backgroundLogin.jpg'),
    fit: BoxFit.cover,
  );

  Widget homePage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/backgroundLogin.jpg'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Icon(
                          Icons.headset_mic,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Watter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          "Plannet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 120.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    Flexible(
                        child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: () => gotoLogin(),
                      child: new Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: Text(
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget loginPage() {
    return Form(
      key: _loginKey,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white, image: customImage),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(100.0),
            child: Center(
              child: Icon(
                Icons.person_pin,
                color: Colors.blueAccent,
                size: 100,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                //Label Email
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        'Email'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ), //Cabezera
              Container(
                  //Input Email
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.blueAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: correo,
                          obscureText: false,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _loginEmail = input,
                          validator: (input) =>
                              input.isEmpty || input.length < 6
                                  ? 'Favor de completar campo'
                                  : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Example@live.com',
                            hintStyle: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  )),
              Divider(
                height: 24.0,
              ),

              Row(
                //Label Password
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        'Password'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ), //Cabezera
              Container(
                  //Input Password
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.blueAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: "test123",
                          obscureText: true,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _loginPassword = input,
                          validator: (input) => input.isEmpty ||
                                  input.length < 6
                              ? 'Favor de completar campo con una clave mayor de 6 digitos'
                              : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '*******',
                            hintStyle: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  )),

              Row(
                //Label for Forgot Password
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FlatButton(
                      child: new Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      onPressed: null,
                    ),
                  ),
                ],
              ),

              Container(
                //Boton Login
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.redAccent,
                        onPressed: () async 
                        {
                          await logIn();
                        },
                        child: Container(
                          //Space
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: Row(
                            //Label Botton
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "LOGIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ])),
      ),
    );
  }

  Widget signUp() {
    return Scaffold(
      body: Container(
        child: Form(
            key: _signUpKey,
            child: Container(
              decoration: customBackgroundPicture,
              child: SingleChildScrollView(
                  child: new Column(children: <Widget>[
                headerofPage("Cuenta Usuario", "assets/images/usuario.png"),
                Column(
                  children: <Widget>[
                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Nombre'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _name = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Pedro Miguel',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),

                    Row(
                      //Label Apellido
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Apellido'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Apellido
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              onSaved: (input) => _lastName = input,
                              validator: (input) => input.isEmpty ||
                                      input.length < 6
                                  ? 'Favor de completar campo con almenos 6 digitos'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ruiz Nunez',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),

                    Row(
                      //Label Correo
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Correo'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Correo
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) => _email = input,
                              validator: (input) => input.isEmpty ||
                                      input.length < 6
                                  ? 'Favor de completar campo con almenos 6 digitos'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Example@live.com',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),

                    Row(
                      //Label Contrasena
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Contraseña'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Contrasena
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: true,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.visiblePassword,
                              onSaved: (input) => _password = input,
                              validator: (input) => input.isEmpty ||
                                      input.length < 6
                                  ? 'Favor de completar campo con al menos 6 digitos'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '*******',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),

                    Row(
                      // Label Direccion
                      children: <Widget>[
                        Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Direccion'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      // Input Direccion
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              onSaved: (input) => _address = input,
                              validator: (input) => input.isEmpty ||
                                      input.length < 6
                                  ? 'Favor de completar campo con almenos 6 digitos'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    'Residencial Prado Oriental, Pimienta #35',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),

                    Row(
                      //Label Telefono
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Telefono'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Telefono
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              onSaved: (input) =>
                                  _phoneNumber = int.parse(input),
                              validator: (input) => input.isEmpty ||
                                      input.length < 6
                                  ? 'Favor de completar campo con almenos 6 digitos'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '809-345-6789',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),

                    Row(
                      //Label for password fogotten
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: new FlatButton(
                            child: new Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            onPressed: gotoLogin,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      // Boton SIGN UP
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 20.0, bottom: 5.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Colors.redAccent,
                              onPressed: signIn,
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "SIGN UP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
            )),
      ),
    );
  }

  Widget signUpAsSupplier() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Form(
            key: _signUpAsSupplierKey,
            child: Container(
              decoration: customBackgroundPicture,
              child: SingleChildScrollView(
                  child: new Column(children: <Widget>[
                headerofPage("Cuenta Empresa", "assets/images/bussines.png"),
                Column(
                  children: <Widget>[
                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Nombre'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _companyName = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nombre de la empresa',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                    ),

                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Numero Contacto'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              onSaved: (value) => _contactPhone = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Contacto',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                    ),

                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Correo Empresarial'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) => _emailSupplier = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Correo',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                    ),

                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Contraseña'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: true,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) => _passwordSupplier = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Contraseña',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                    ),

                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Direccion'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _addressSuplier = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Residencial, Calle #',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                    ),

                    Row(
                      //Label Nombre
                      children: <Widget>[
                        new Expanded(
                          //Label Nombre
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              'Ciudad'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //Cabezera
                    Container(
                      //Input Nombre
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blueAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              obscureText: false,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _citySupplier = value,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6)
                                  return 'Favor de completar este campo con al menos 6 digitos';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ciudad de ubicacion',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                    ),

                    Row(
                      //Label for password fogotten
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: new FlatButton(
                            child: new Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            onPressed: gotoLogin,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      // Boton SIGN UP AS Supplier
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 20.0, bottom: 5.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Colors.redAccent,
                              onPressed: signInAsSupplier,
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "SIGN UP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
            )),
      ),
    );
  }

  Future<void> logIn() async
  {
    var output;

    if (_loginKey.currentState.validate()) 
    {
      _loginKey.currentState.save();

      output =
          await _auth.loginWithEmailAndPassword(_loginEmail, _loginPassword);
      

      if (output.runtimeType != String && output != null) 
      {

       User userlogged = await getUser(output.email);
      

       Navigator.pushReplacementNamed(context, userlogged.loggin() , arguments: userlogged);

        _loginKey.currentState.reset();

      } 
      else 
      {
        flusBar.getBar(
            context: context, title: 'Notificacion', message: output);
      }
    }
  }

  Future<dynamic> getUser(String email) async 
  {

    //TODO CREAR LISTADO DE CORREOS PARA IDENTIFCAR ROLES
     var user;

    DataSnapshot p = await FirebaseData.database
        .reference()
        .child(NameDocumentsTable.tableDocumentSupplies)
        .orderByChild("email")
        .equalTo(email)
        .limitToFirst(1)
        .once();

    if (p.value != null) 
    {

          Map<dynamic, dynamic> values = p.value;


      values.forEach((key, value) 
      {
        user = Supplier.fromMap(
            supplierID: key,
            companyName: value["companyName"],
            address: value["address"],
            city: value["city"],
            phoneNumber: value["contactPhone"],
            email: value["email"],
            keyAccountUID: value["keyAccountUID"],
            password: value["password"]);
      });


      return user;
    }
    else
    {


        DataSnapshot userData = await FirebaseData.database
        .reference()
        .child(NameDocumentsTable.tableDocumentConsumer)
        .orderByChild("email")
        .equalTo(email)
        .limitToFirst(1)
        .once();

         Map<dynamic, dynamic> valuesUserData = userData.value;

    
        valuesUserData.forEach((key, value) { 

          user = Consumer.fromLogin(key, value);

        });

        
        
        return user;
    }


  }

  void signIn() 
    async {
      var outputFromEmailAccount;

    if (this._signUpKey.currentState.validate()) 
    {
      this._signUpKey.currentState.save();



      outputFromEmailAccount =  await _auth.registerUser(_email, _password);

      if( outputFromEmailAccount != null && outputFromEmailAccount.runtimeType !=  String )
      {
          Consumer(
          email: this._email.trim(),
          password: this._password.trim(),
          name: this._name.trim(),
          lastName: this._lastName.trim(),
          address: this._address.trim(),
          phoneNumber: this._phoneNumber.toString().trim());

          this._signUpKey.currentState.reset();

          FlusBar().getBar(context: context, message: "Usuario Registrado.");
      }
      else 
      {
         FlusBar().getBar(context: context, message: outputFromEmailAccount);
      }

    } else 
    {
       FlusBar().getBar(context: context, message: "Favor validar informacion.");
    }

  }

  void signInAsSupplier() async {
    var outputFromEmailAccount;

    if (this._signUpAsSupplierKey.currentState.validate()) {
      this._signUpAsSupplierKey.currentState.save();

      outputFromEmailAccount =
          await _auth.registerUser(_emailSupplier, _passwordSupplier);

      if (outputFromEmailAccount.runtimeType != String &&
          outputFromEmailAccount != null) {
        Supplier(
            keyAccountUID: outputFromEmailAccount.uid,
            companyName: _companyName.trim(),
            phoneNumber: _contactPhone.trim(),
            email: _emailSupplier.trim(),
            password: _passwordSupplier.trim(),
            address: _addressSuplier.trim(),
            city: _citySupplier.trim());

        flusBar.getBar(
            context: context,
            title: "Notificacion",
            message: "Cuenta de Empresa Creada.");
        this._signUpAsSupplierKey.currentState.reset();
      } else {
        flusBar.getBar(
            context: context,
            title: "Notificacion",
            message: outputFromEmailAccount);
        print(this._signUpAsSupplierKey.currentState);
        return;
      }
    }
  }

  Widget wrapperForms() {
    PageController _controllerForm =
        new PageController(initialPage: 0, viewportFraction: 1.0);

    return Scaffold(
        appBar: AppBar(
          title: Text("Formulario"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.backspace),
              alignment: Alignment.center,
              tooltip: "",
              onPressed: () {
                gotoLogin(1);
              },
            )
          ],
        ),
        body: Container(
          child: PageView(
            controller: _controllerForm,
            physics: new AlwaysScrollableScrollPhysics(),
            children: <Widget>[signUp(), signUpAsSupplier()],
            scrollDirection: Axis.horizontal,
          ),
        ));
  }

  void gotoLogin([int page = 0]) {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      page,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  void gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  Widget customTextField( var fieldC, String hintext, String header, bool isObscureText,int minimunLength,
      [TextInputType typeofInput = TextInputType.text]) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: new Text(
                  header.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ), //Cabezera
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.blueAccent,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  obscureText: isObscureText,
                  textAlign: TextAlign.left,
                  keyboardType: typeofInput,
                  onSaved: (input) => setState(() => fieldC = input),
                  validator: (input) => validator(input,minimunLength),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintext,
                    hintStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 24.0,
        )
      ],
    );
  }

  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: PageView(
        controller: _controller,
        physics: new AlwaysScrollableScrollPhysics(),
        children: <Widget>[loginPage(), homePage(), wrapperForms()],
        scrollDirection: Axis.horizontal,
      )),
    );
  }
}
