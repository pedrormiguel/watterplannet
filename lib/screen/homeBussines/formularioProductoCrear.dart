import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/homeBussines/mainPageBussines.dart';
import 'package:watterplannet/utils/FlushBart.dart';
import 'package:watterplannet/utils/validators.dart';

class FormularioProductoCrear extends StatefulWidget {
  @override
  _FormularioProductoCrearState createState() =>
      _FormularioProductoCrearState();
}

class _FormularioProductoCrearState extends State<FormularioProductoCrear> {
  String name = "", category, description;
  double price;
  int unitInStock;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            'Formulario para registrar Producto'.toUpperCase(),
            //style: TextStyle(fontSize: 50),
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            
          ),
        ),
        body: SingleChildScrollView(
                  child: Container(
              height: MediaQuery.of(context).size.height * 0.90,
         
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: new Text(
                                  'titulo'.toUpperCase(),
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
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => name = input,
                                  validator: (input) => validator(input, 5),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nombre del producto',
                                    hintStyle:
                                        TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                      ]),

                      Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: new Text(
                                  'Categoria'.toUpperCase(),
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
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => category = input,
                                  validator: (input) => validator(input, 3),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Lacteo, dulce, gaseoso ...',
                                    hintStyle:
                                        TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                      ]),
                      Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: new Text(
                                  'Descripcion'.toUpperCase(),
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
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => description = input,
                                  validator: (input) => validator(input, 3),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Detalles del producto',
                                    hintStyle:
                                        TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                      ]),
                      Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: new Text(
                                  'Valor del articulo'.toUpperCase(),
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
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  onSaved: (input) =>
                                      price = double.parse(input),
                                  validator: (input) => validator(input, 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Precio por unidad',
                                    hintStyle:
                                        TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                      ]),
                      Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: new Text(
                                  'Unidad en Stock'.toUpperCase(),
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
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  onSaved: (input) =>
                                      unitInStock = int.parse(input),
                                  validator: (input) => validator(input, 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Unidades disponibles',
                                    hintStyle:
                                        TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                      ]),
                      Container(
                        // Boton SIGN UP
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 20.0,
                            bottom: 5.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0),
                                ),
                                color: Colors.redAccent,
                                onPressed: agregarProducto,
                                child: new Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 20.0,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "Agregar Producto".toUpperCase(),
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
                ),
              )),
        ));
  }

  Widget customTextField(
      var fieldC, String hintext, String header, bool isObscureText, int length,
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
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.blueAccent,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          //padding: const EdgeInsets.only(left: 0.0, right: 10.0),

          child: new Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  obscureText: isObscureText,
                  textAlign: TextAlign.left,
                  keyboardType: typeofInput,
                  //onSaved: (input) { setState(() => fieldC = input) ; },
                  onSaved: (input) => asignValue(fieldC, input),
                  validator: (input) => validator(input, length),
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
          height: 10.0,
        )
      ],
    );
  }

  agregarProducto() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      Product(
          name: name.trim(),
          category: category.trim(),
          description: description.trim(),
          image: 'assets/images/mountains.jpeg',
          price: price,
          supplierID: MainPageBussines.user.getIdFromFireBase(),
          unitInStock: unitInStock);

      _formkey.currentState.reset();

      FlusBar().getBar(
          context: context,
          title: 'Notificacion',
          message: "Producto registado con exito.");
    }
  }

  void asignValue(String campo, String value) {
    campo = value;
  }
}
