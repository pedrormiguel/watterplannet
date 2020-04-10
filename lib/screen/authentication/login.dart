import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watterplannet/services/Auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  Authentication _auth = Authentication();

  // FlusBar flusBar = FlusBar();

  String _email, _password, _address, _name, _lastName;
  int _phoneNumber;
  String _title = 'Create Account';

  var headerofPage = Container(
    padding: EdgeInsets.only(top: 25.0, bottom: 20),
    child: Center(
      child: Column(children: <Widget>[
        Icon(
          Icons.headset_mic,
          color: Colors.redAccent,
          size: 50.0,
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Create Account',
          style: TextStyle(fontSize: 35),
        ),
      ]),
    ),
  );

  var customBackgroundPicture = BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.05), BlendMode.dstATop),
        image: AssetImage(''),
        fit: BoxFit.cover,
      ));

  @override
  void initState() {
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
    image: AssetImage(''),
    fit: BoxFit.cover,
  );

  Widget homePage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage(''),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          )),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
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
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
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
              child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
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
                  ),
                ),
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
      child: new Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white, image: customImage),
        child: SingleChildScrollView(
            child: new Column(children: <Widget>[
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
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
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
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _email = input,
                          validator: (input) {
                            if (input.runtimeType == String) {
                              if (input.isEmpty) {
                                return 'Favor de completar el campo';
                              } else if (input.length < 6) {
                                return 'Debe tener al menos 6 caracteres';
                              }
                            } else {
                              if (input.length < 6) {
                                return 'Debe tener al menos 6 caracteres';
                              }
                            }
                          },
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
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
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
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _password = input,
                          validator: (input) {
                            if (input.runtimeType == String) {
                              if (input.isEmpty) {
                                return 'Favor de completar el campo';
                              } else if (input.length < 6) {
                                return 'Debe tener al menos 6 caracteres';
                              }
                            } else {
                              if (input.length < 6) {
                                return 'Debe tener al menos 6 caracteres';
                              }
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '*******',
                            hintStyle: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  )),
              new Row( //Label
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: new FlatButton(
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
              new Container( //Boton Login
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.redAccent,
                        onPressed: () async {
                          this._loginKey.currentState.save();
                          print( await _auth.singwithEmail(this._email, this._password));
                        } ,
                        child: new Container( //Space
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row( //Label Botton
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
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

  // void logIn() async {
  //   if (_loginKey.currentState.validate()) {
  //     _loginKey.currentState.save();

  //     var output = await service.loginWithEmailAndPassword(_email, _password);

  //       if(output.runtimeType == String){
  //                flusBar.getBar(context: context,title: 'Notificacion',message: output ); //To-Do
  //       }
  //       else{
  //           Navigator.pushNamed(context, 'home');
  //       }

  //   } else {
  //     print('faliled saving the data from the form');
  //   }
  // }

  // void signIn() async {

  //   if(_signUpKey.currentState.validate()){
  //     _signUpKey.currentState.save();

  //       var output = await service.signWithEmailAndPassword(_email, _password);

  //       if(output.runtimeType == String){
  //          flusBar.getBar(context: context,title: 'Notificacion',message: output.toString()); //ToDo
  //       }
  //       else{
  //         flusBar.getBar(context: context,title: 'Notificacion',message: "Usuario Creado con Exito, ver correo."); //ToDo
  //         _signUpKey.currentState.reset();
  //       }

  //   }

  // }

  Widget signupPage() {
    return Form(
        key: _signUpKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: customBackgroundPicture,
          child: SingleChildScrollView(
              child: new Column(children: <Widget>[
            headerofPage,
            Column(
              children: <Widget>[

                new Row( //Label Nombre
                  children: <Widget>[
                    new Expanded( //Label Nombre
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
                Container(//Input Nombre
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
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _name = input,
                          validator: (input) {
                            if (input.runtimeType == String) {
                              if (input.isEmpty) {
                                return 'Favor de completar el campo';
                              } else if (input.length < 6) {
                                return 'Debe tener al menos 6 caracteres';
                              }
                            } else {
                              if (input.length < 6) {
                                return 'Debe tener al menos 6 caracteres';
                              }
                            }
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
                
                Column(children: <Widget>[
                  new Row(//Label Apellido
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
                  Container(//Input Apellido
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
                            validator: (input) {
                              if (input.runtimeType == String) {
                                if (input.isEmpty) {
                                  return 'Favor de completar el campo';
                                } else if (input.length < 6) {
                                  return 'Debe tener al menos 6 caracteres';
                                }
                              } else {
                                if (input.length < 6) {
                                  return 'Debe tener al menos 6 caracteres';
                                }
                              }
                            },
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
                ]),

                Column(children: <Widget>[
                  new Row(//Label Correo
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
                  Container(//Input Correo
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
                            validator: (input) {
                              if (input.runtimeType == String) {
                                if (input.isEmpty) {
                                  return 'Favor de completar el campo';
                                }
                              }
                            },
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
                  )
                ]),

                Column(children: <Widget>[
                  new Row(//Label Contrasena
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
                  Container( //Input Contrasena
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
                            validator: (input) {
                              if (input.runtimeType == String) {
                                if (input.isEmpty) {
                                  return 'Favor de completar el campo';
                                } else if (input.length < 6) {
                                  return 'Debe tener al menos 6 caracteres';
                                }
                              } else {
                                if (input.length < 6) {
                                  return 'Debe tener al menos 6 caracteres';
                                }
                              }
                            },
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
                  )
                ]),

                Column(children: <Widget>[
                  new Row( // Label Direccion
                    children: <Widget>[
                      new Expanded(
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
                  Container( // Input Direccion
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
                            validator: (input) {
                              if (input.runtimeType == String) {
                                if (input.isEmpty) {
                                  return 'Favor de completar el campo';
                                }
                              }
                            },
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
                  )
                ]),

                Column(children: <Widget>[
                  new Row( //Label Telefono
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
                  Container(//Input Telefono
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
                            onSaved: (input) => _phoneNumber = int.parse(input),
                            validator: (input) {
                              if (input.runtimeType == String) {
                                if (input.isEmpty) {
                                  return 'Favor de completar el campo';
                                } else if (input.length < 6) {
                                  return 'Debe tener al menos 6 caracteres';
                                }
                              } else {
                                if (input.length < 6) {
                                  return 'Debe tener al menos 6 caracteres';
                                }
                              }
                            },
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
                  )
                ]),

                Row( //Label for password fogotten
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

                Container( // Boton SIGN UP
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
                          onPressed: () => null, //signIn(),
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
        ));
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  Widget customTextField(
      var fieldC, String hintext, String header, bool isObscureText,
      [TextInputType typeofInput = TextInputType.text]) {
    return Column(children: <Widget>[
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
                color: Colors.blueAccent, width: 0.5, style: BorderStyle.solid),
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
                onSaved: (input) => fieldC = input,
                validator: (input) {
                  if (input.runtimeType == String) {
                    if (input.isEmpty) {
                      return 'Favor de completar el campo';
                    } else if (input.length < 6) {
                      return 'Debe tener al menos 6 caracteres';
                    }
                  } else {
                    if (input.length < 6) {
                      return 'Debe tener al menos 6 caracteres';
                    }
                  }
                },
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
    ]);
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: new AlwaysScrollableScrollPhysics(),
            children: <Widget>[loginPage(), homePage(), signupPage()],
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
