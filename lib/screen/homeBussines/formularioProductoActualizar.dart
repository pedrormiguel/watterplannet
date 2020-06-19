
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/utils/FlushBart.dart';
import 'package:watterplannet/utils/validators.dart';

class FormularioProductoActualizar extends StatelessWidget {
  String name, category, descripcion;
  double itemPrice;
  int itemStock;
  Product productToUpdate;
  final GlobalKey<FormState> _formkeyToUpdate = GlobalKey<FormState>();


  // const FormularioProductoActualizar({Key key, this.name, this.category, this.descripcion, this.itemPrice, this.itemStock}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    productToUpdate = ModalRoute.of(context).settings.arguments;
    name = productToUpdate.name;
    category = productToUpdate.category;
    descripcion = productToUpdate.description;
    itemPrice = productToUpdate.price;
    itemStock = productToUpdate.unitInStock;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Formulario para actualizar Producto'.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.90,
          child: Center(
              child: Form(
                key: _formkeyToUpdate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               
                Column(children: <Widget>[
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
                    margin:
                        const EdgeInsets.only(left: 40.0, right: 40.0, top: 2),
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
                            initialValue: name,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => name = input,
                            validator: (input) => validator(input, 5),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nombre del producto',
                              hintStyle: TextStyle(color: Colors.blueGrey),
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
                    margin:
                        const EdgeInsets.only(left: 40.0, right: 40.0, top: 2),
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
                            initialValue: category,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => category = input,
                            validator: (input) => validator(input, 3),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Lacteo, dulce, gaseoso ...',
                              hintStyle: TextStyle(color: Colors.blueGrey),
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
                    margin:
                        const EdgeInsets.only(left: 40.0, right: 40.0, top: 2),
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
                            initialValue: descripcion,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => descripcion = input,
                            validator: (input) => validator(input, 3),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Detalles del producto',
                              hintStyle: TextStyle(color: Colors.blueGrey),
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
                    margin:
                        const EdgeInsets.only(left: 40.0, right: 40.0, top: 2),
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
                            initialValue: itemPrice.toString(),
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.number,
                            onSaved: (input) => itemPrice = double.parse(input),
                            validator: (input) => validator(input, 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Precio por unidad',
                              hintStyle: TextStyle(color: Colors.blueGrey),
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
                    margin:
                        const EdgeInsets.only(left: 40.0, right: 40.0, top: 2),
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
                            initialValue: itemStock.toString(),
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.number,
                            onSaved: (input) => itemStock = int.parse(input),
                            validator: (input) => validator(input, 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Unidades disponibles',
                              hintStyle: TextStyle(color: Colors.blueGrey),
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
                          onPressed: () async { await actualizarProducto(context); },
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
                                    "Actualizar Producto".toUpperCase(),
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
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> actualizarProducto(BuildContext context) async {

    if(_formkeyToUpdate.currentState.validate())
    {
      _formkeyToUpdate.currentState.save();

     await Product.actualizarProduct(
        id: productToUpdate.productID,
        name: name,
        category: category,
        description: descripcion,
        price: itemPrice,
        unitInStock: itemStock
      );

      FlusBar().getBar(context: context,title: "Notificacion",message: "Producto Actualizado Correctamente.");
    }
    
 }
 }