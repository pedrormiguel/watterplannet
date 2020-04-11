
import 'package:flutter/material.dart';
import 'package:watterplannet/class/user.dart';

class SingUpPage {
   
   Function gotoLogin;
   SingUpPage(this.gotoLogin);

   final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

   String _email, _password, _address, _name, _lastName;

   int _phoneNumber;

   User newUser;

    var customBackgroundPicture = BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.05), BlendMode.dstATop),
        image: AssetImage(''),
        fit: BoxFit.cover,
      ));

    var headerofPage = Container(
          padding: EdgeInsets.only(top: 25.0, bottom: 20),
          child:   Center(
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

    void signIn() {

    final FormState form = this._signUpKey.currentState;

    if ( form.validate())  {

      form.save();
      form.reset();

      newUser = User(
        email:       this._email,
        password:    this._password,
        name:        this._name,
        lastName:    this._lastName,
        address:     this._address,
        phoneNumber: this._phoneNumber.toString()
      );

    }else {
      print(form.context.widget.key);
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

}

