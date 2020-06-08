import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/utils/drawerMenu.dart';
import 'package:watterplannet/utils/drawerOptions.dart';


class MainPageBussines extends StatefulWidget {
  MainPageBussines({Key key}) : super(key: key);
  
  static FirebaseUser perfil;
  static User user;
  

  @override
  _MainPageBussinesState createState() => _MainPageBussinesState();
}

class _MainPageBussinesState extends State<MainPageBussines> {

  DraweMenu draweMenu;
  
  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

       MainPageBussines.user = ModalRoute.of(context).settings.arguments;

      draweMenu  = new DraweMenu 
                    (
                      user: MainPageBussines.user,
                      drawerOptions: getOptionsMenu()
                    );

    return Scaffold(
      appBar: AppBar(),
      body: listProduct(MainPageBussines.user.getIdFromFireBase()),
      drawer: draweMenu,
    );

  }

  List<DrawerOptions> getOptionsMenu() {
        return 
        [
          DrawerOptions
         ( 
            title:"Agregar Producto",
            icon:Icon(Icons.library_add),
           function: () => Navigator.popAndPushNamed(context, 'formCreateProduct'), 
         ),
          DrawerOptions
         ( 
            title:"Cerrar sesion",
            icon:Icon(Icons.exit_to_app),
           function: () => Navigator.pushReplacementNamed(context, '/'), 
         ),

        ];
  } 
  
  Widget listProduct(String id) 
  {
    return StreamBuilder(

        stream: Product.productRef
                .orderByChild("supplierID")
                .equalTo(id)
                .onValue,

        builder: (context, AsyncSnapshot<Event> snapshot) 
        {

          var grade = snapshot.connectionState.toString();

          switch (grade) 
          {
            case "ConnectionState.active":
              {
                Map<dynamic, dynamic> values =
                    snapshot.data.snapshot.value != null
                        ? snapshot.data.snapshot.value
                        : Map<dynamic, dynamic>();

                var listSuppliesProduct = List<Product>();

                 values.forEach( (key, value) 
                 {

                    listSuppliesProduct.add
                    (
                      Product.fromMap(
                                    productID: key,
                                    image: value["image"],
                                    price: double.parse(value["price"].toString()),
                                    isSelected: value["isSelected"],
                                    name: value["name"],
                                    description: value["description"],
                                    category: value["category"],
                                    supplierID: value["supplierID"],
                                    isLiked: value["isliked"],
                                    unitInStock: value["unitInStock"])
                    );
                 });                  
        
                return listSuppliesProduct.length > 0 ? productListSupplier(listSuppliesProduct)  : withOutProduct();
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

  Widget productListSupplier( List<Product> listSuppliesProduct) {
    return  Center(
                        child: ListView.builder(
                            itemCount: listSuppliesProduct.length,
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
                                            listSuppliesProduct[index]
                                                .image,
                                          ),
                                        ),
                                        title: Text(
                                            listSuppliesProduct[index]
                                                .name,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        subtitle: Text(
                                            listSuppliesProduct[index]
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
                                                  arguments: listSuppliesProduct
                                                      .elementAt(index));
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Borrar',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () async {
                                              var id = listSuppliesProduct
                                                  .elementAt(index)
                                                  .productID;

                                                 // listSuppliesProduct.elementAt(index).

                                              await Product.eliminarProduct(id);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                                'Stock ' +
                                                    listSuppliesProduct
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
                      );
  }

  Widget withOutProduct() 
  {

    return Center
    (
            child: AutoSizeText
            (
              "No tiene productos agregados",
              maxFontSize: 150,
              textAlign: TextAlign.center,
              minFontSize: 25,
              maxLines: 1,
              style:TextStyle(height: 2, fontWeight: FontWeight.bold),
           )
    );
  }

}