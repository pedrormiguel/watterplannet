import 'package:flutter/material.dart';
import 'package:watterplannet/class/user.dart';
import 'package:watterplannet/screen/home/home_page.dart';
import 'package:watterplannet/services/Auth.dart';
import 'package:flutter/services.dart';
import 'package:watterplannet/utils/FlushBart.dart';
import 'package:watterplannet/utils/validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  FlusBar flusBar = FlusBar();

  Authentication _auth = Authentication();

  String _email, _password, _address, _name, _lastName;
  int _phoneNumber;
  User newUser;

  var customBackgroundPicture = BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.05), BlendMode.dstATop),
        image: AssetImage('assets/backgroundLogin.jpg'),
        fit: BoxFit.cover,
      ));

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

  String _loginEmail, _loginPassword;

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
    image: AssetImage('assets/backgroundLogin.jpg'),
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
          image: AssetImage('assets/backgroundLogin.jpg'),
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
                        onPressed: () => logIn(),
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
                Row( //Label Nombre
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
                Container( //Input Nombre
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

                Row( //Label Apellido
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
                Container( //Input Apellido
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
                Divider (
                  height: 24.0,
                ),

                Row( //Label Correo
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
                Container( //Input Correo
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

                Row( //Label Contrasena
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

                Row( // Label Direccion
                  children: 
                  <Widget>[ Expanded(
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

                Row( //Label Telefono
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
                Container( //Input Telefono
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
                          keyboardType: TextInputType.phone,
                          onSaved: (input) => _phoneNumber = int.parse(input),
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
        ));
  }

  void logIn() async {

    var output ;

    if (_loginKey.currentState.validate()) {
      _loginKey.currentState.save();

       output =
          await _auth.loginWithEmailAndPassword(_loginEmail, _loginPassword);

      if(output.runtimeType == String){
        
        flusBar.getBar(context: context,title: 'Notificacion',message: output ); 
      }
      else{
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
      //print(output.isEmailVerified);
      


    } else {
      print('faliled saving the data from the form');
    }
  }

  void signIn() {
    if (this._signUpKey.currentState.validate()) {
      this._signUpKey.currentState.save();
      this._signUpKey.currentState.reset();

      var output = newUser = User(
          email: this._email.trim(),
          password: this._password.trim(),
          name: this._name.trim(),
          lastName: this._lastName.trim(),
          address: this._address.trim(),
          phoneNumber: this._phoneNumber.toString().trim());

      var outputFromEmailAccount = _auth.registerUser(_email, _password);

      print(output);
      print(outputFromEmailAccount);
    } else {
      print(this._signUpKey.currentState);
    }

    // if(_signUpKey.currentState.validate()){
    //   _signUpKey.currentState.save();

    //     var output = await service.signWithEmailAndPassword(_email, _password);

    //     if(output.runtimeType == String){
    //        flusBar.getBar(context: context,title: 'Notificacion',message: output.toString()); //ToDo
    //     }
    //     else{
    //       flusBar.getBar(context: context,title: 'Notificacion',message: "Usuario Creado con Exito, ver correo."); //ToDo
    //       _signUpKey.currentState.reset();
    //     }

    // }
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
                onSaved: (input) => setState(() => fieldC = input),
                validator: (input) => validator(input),
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
            children: <Widget>[loginPage(), homePage(), signUp()],
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
