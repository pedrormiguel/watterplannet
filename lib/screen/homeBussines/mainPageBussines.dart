import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/utils/drawer/drawerMenu.dart';
import 'package:watterplannet/utils/drawer/drawerOptions.dart';
import 'package:getwidget/getwidget.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainPageBussines.user = ModalRoute.of(context).settings.arguments;

    draweMenu = new DraweMenu(
        user: MainPageBussines.user, drawerOptions: getOptionsMenu());

    return Scaffold(
      appBar: AppBar(),
      body: listProduct(MainPageBussines.user.getIdFromFireBase()),
      drawer: draweMenu,
    );
  }

  List<DrawerOptions> getOptionsMenu() {
    return [
      DrawerOptions(
        title: "Agregar Producto",
        icon: Icon(Icons.library_add),
        function: () => Navigator.popAndPushNamed(context, 'formCreateProduct'),
      ),
      DrawerOptions(
        title: "Cerrar sesion",
        icon: Icon(Icons.exit_to_app),
        function: () => Navigator.pushReplacementNamed(context, '/'),
      ),
    ];
  }

  Widget listProduct(String id) {
    return StreamBuilder(
        stream:
            Product.productRef.orderByChild("supplierID").equalTo(id).onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          var grade = snapshot.connectionState.toString();

          switch (grade) {
            case "ConnectionState.active":
              {
                Map<dynamic, dynamic> values =
                    snapshot.data.snapshot.value != null
                        ? snapshot.data.snapshot.value
                        : Map<dynamic, dynamic>();

                var listSuppliesProduct = List<Product>();

                values.forEach((key, value) {
                  listSuppliesProduct.add(Product.fromMap(
                      productID: key,
                      image: value["image"],
                      price: double.parse(value["price"].toString()),
                      isSelected: value["isSelected"],
                      name: value["name"],
                      description: value["description"],
                      category: value["category"],
                      supplierID: value["supplierID"],
                      isLiked: value["isliked"],
                      unitInStock: value["unitInStock"]));
                });

                return listSuppliesProduct.length > 0
                    ? productListSupplier(listSuppliesProduct)
                    : withOutProduct();
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

  Widget productListSupplier(List<Product> listSuppliesProduct) {
    return Center(
      child: ListView.builder(
          itemCount: listSuppliesProduct.length,
          itemBuilder: (BuildContext context, int index) {
            return GFCard(
              borderOnForeground: true,
              boxFit: BoxFit.cover,
              image: Image.network(
                listSuppliesProduct[index].image,
                height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * 1,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(

                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width * 1,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes !=null 
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                        : null
                      ),
                    ),
                  );
                },
                fit: BoxFit.fitHeight,
              ),
              title: GFListTile(
                avatar: GFAvatar(),
                title: Text(
                  listSuppliesProduct[index].name,
                ),
                subTitle: Text(listSuppliesProduct[index].category),
              ),
              content: Text(listSuppliesProduct[index].description),
              buttonBar: GFButtonBar(
                  alignment: WrapAlignment.spaceAround,
                  children: <Widget>[
                    GFButton(
                      onPressed: () => Navigator.pushNamed(
                          context, 'formUpdateProduct',
                          arguments: listSuppliesProduct.elementAt(index)),
                      text: 'Editar',
                    ),
                    GFButton(
                      onPressed: () async => await Product.eliminarProduct(
                          listSuppliesProduct.elementAt(index).productID),
                      text: 'Borrar',
                    ),
                    GFButton(
                        onPressed: () {},
                        shape: GFButtonShape.pills,
                        child: Text('Stock ' +
                            listSuppliesProduct
                                .elementAt(index)
                                .unitInStock
                                .toString())),
                  ]),
            );
          }),
    );
  }

  Widget withOutProduct() {
    return Center(
        child: AutoSizeText(
      "No tiene productos agregados",
      maxFontSize: 150,
      textAlign: TextAlign.center,
      minFontSize: 25,
      maxLines: 1,
      style: TextStyle(height: 2, fontWeight: FontWeight.bold),
    ));
  }
}
