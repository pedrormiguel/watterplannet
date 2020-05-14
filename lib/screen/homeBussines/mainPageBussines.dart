import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/perfil.dart';
import 'package:watterplannet/class/product.dart';

class MainPageBussines extends StatefulWidget {
  MainPageBussines({Key key}) : super(key: key);
  static FirebaseUser perfil;

  @override
  _MainPageBussinesState createState() => _MainPageBussinesState();
}

class _MainPageBussinesState extends State<MainPageBussines> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainPageBussines.perfil = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: listProduct(),
      drawer: drawerSupplier(),
    );
  }

  Widget drawerSupplier() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(MainPageBussines.perfil.uid),
            accountName: Text(MainPageBussines.perfil.email),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          drawerOptions('Agregar Producto', Icon(Icons.filter_none),
              () => Navigator.pushNamed(context, 'formCreateProduct')),
          drawerOptions('Cerrar sesion', Icon(Icons.exit_to_app),
              () => Navigator.pushReplacementNamed(context, '/'))
        ],
      ),
    );
  }

  Widget bussinesAccount(AsyncSnapshot<Event> snapshot) {
    Map<dynamic, dynamic> values = snapshot.data.snapshot.value;
    String companyName;

    values.forEach((key, value) {
      companyName = value["companyName"];
    });

    return Scaffold(
      appBar: AppBar(),
      body: listProduct(),
      drawer: drawerSupplier(),
    );
  }

  Widget listProduct() {
    return StreamBuilder(
        stream: Product.productRef
            .orderByChild("suppliesID")
            .equalTo(MainPageBussines.perfil.uid)
            .onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          var grade = snapshot.connectionState.toString();

          switch (grade) {
            case "ConnectionState.active":
              {
                Map<dynamic, dynamic> values =
                    snapshot.data.snapshot.value != null
                        ? snapshot.data.snapshot.value
                        : Map<dynamic, dynamic>();

                Perfil.listSuppliesProduct = List<Product>();

                values.forEach((key, value) {
                  Perfil.listSuppliesProduct.add(Product.fromMap(
                      productID: key,
                      image: value["image"],
                      price: double.parse(value["price"].toString()),
                      isSelected: value["isSelected"],
                      name: value["name"],
                      description: value["description"],
                      category: value["category"],
                      suppliesID: value["suppliesID"],
                      isLiked: value["isliked"],
                      unitInStock: value["unitInStock"]));
                });

                return values.length > 0
                    ? Center(
                        child: ListView.builder(
                            itemCount: Perfil.listSuppliesProduct.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 200,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.blue[200],
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        // contentPadding:
                                        //     EdgeInsets.only(top:10, left: 15),
                                        leading: ClipOval(
                                          child: Image.asset(
                                            Perfil.listSuppliesProduct[index]
                                                .image,
                                          ),
                                        ),
                                        title: Text(
                                            Perfil.listSuppliesProduct[index]
                                                .name,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        subtitle: Text(
                                            Perfil.listSuppliesProduct[index]
                                                .category,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text('Editar',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, 'formUpdateProduct',
                                                  arguments: Perfil
                                                      .listSuppliesProduct
                                                      .elementAt(index));
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Borrar',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () async {
                                              var id = Perfil
                                                  .listSuppliesProduct
                                                  .elementAt(index)
                                                  .productID;

                                              await Product.eliminarProduct(id);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                                'Stock ' +
                                                    Perfil.listSuppliesProduct
                                                        .elementAt(index)
                                                        .unitInStock
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: null,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: AutoSizeText(
                        "No tiene productos agregados",
                        maxFontSize: 150,
                        textAlign: TextAlign.center,
                        minFontSize: 25,
                        maxLines: 1,
                        style:
                            TextStyle(height: 2, fontWeight: FontWeight.bold),
                      ));
              }
              break;

            case "ConnectionState.waiting":
            default:
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ));
              break;
          }
        });
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
