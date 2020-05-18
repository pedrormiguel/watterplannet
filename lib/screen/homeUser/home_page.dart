import 'package:flutter/material.dart';
import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/homeUser/product_card.dart';
import 'package:watterplannet/screen/homeUser/product_icon.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _categoryWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        height: 80,
       // decoration: BoxDecoration(border: Border.all(color: Colors.teal)),
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: AppData.categoryList
                .map((category) => ProducIcon(
                      model: category,
                    ))
                .toList()),
      ),
    );
  }
  //p

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: gridSystemBuild(context),
    );
  }

  Widget gridSystem() {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: Product.listOfAllProduct
            .map((product) => ProductCard(
                  product: product,
                ))
            .toList());
  }

  Widget gridSystemBuild(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: Product.productRef.onValue,
            builder: (context, AsyncSnapshot snapshot) {
              var grade = snapshot.connectionState.toString();

              switch (grade) {
                case "ConnectionState.waiting":
                  {
                    return Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    );
                  }
                  break;

                case "ConnectionState.active":
                  Map<dynamic, dynamic> values =
                      snapshot.data.snapshot.value != null
                          ? snapshot.data.snapshot.value
                          : Map<dynamic, dynamic>();

                  Product.listOfAllProduct = List<Product>();

                  values.forEach((key, value) {
                    Product.listOfAllProduct.add(Product.fromMap(
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

                  return gridSystem();
                  break;

                default:
                  return Text("data :" + snapshot.connectionState.toString());
                  break;
              }
            }));
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_search(), _categoryWidget(), _productWidget()],
      )),
    );
  }
}
