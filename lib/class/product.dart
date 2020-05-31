import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class Product {
  String productID;
  final String suppliesID;
  final String name;
  final String description;
  final double price;
  final int unitInStock;
  var snapshot;
  static List<Product> listOfAllProduct;
  //final DatabaseReference mdatabase = FirebaseDatabase.instance.reference();

  final String category;
  final String image;
  bool isLiked;
  bool isSelected;

  FirebaseDatabase database = FirebaseDatabase.instance;

  static DatabaseReference productRef =
      FirebaseData.database.reference().child('product');

  Product(
      {this.suppliesID,
      this.name,
      this.description,
      this.price,
      this.unitInStock,
      this.category,
      this.image}) {
    this.isSelected = false;
    this.isLiked = false;
    handleSubmit();
  }


  Product.fromMap(
      {this.productID,
      this.suppliesID,
      this.name,
      this.description,
      this.price,
      this.unitInStock,
      this.category,
      this.image,
      this.isSelected,
      this.isLiked});

  void handleSubmit() async {
    print(toJson());
    await productRef.push().set(toJson());
  }

  Product.fromSnapshot(DataSnapshot snapshot)
      : productID   = snapshot.key == null ? "" : snapshot.key,
        suppliesID  = snapshot.value["suppliesID"] = null ? "" : snapshot.value["suppliesID"],
        name        = snapshot.value["name"],
        description = snapshot.value["description"],
        price       = double.parse(snapshot.value["price"]),
        unitInStock = int.parse(snapshot.value["unitInStock"]),
        category    = snapshot.value["category"],
        image       = snapshot.value["image"],
        isLiked     = snapshot.value["isLiked"],
        isSelected  = snapshot.value["isSelected"];

  // Product.fromMap(String key, Map value)
  //  :    productID   = key,
  //       suppliesID  = snapshot.value["suppliesID"] = null ? "" : snapshot.value["suppliesID"],
  //       name        = snapshot.value["name"],
  //       description = snapshot.value["description"],
  //       price       = double.parse(snapshot.value["price"]),
  //       unitInStock = int.parse(snapshot.value["unitInStock"]),
  //       category    = snapshot.value["category"],
  //       image       = snapshot.value["image"],
  //       isLiked     = snapshot.value["isLiked"],
  //       isSelected  = snapshot.value["isSelected"];

   

  toJson() {
    return {
      "suppliesID": suppliesID,
      "name": name,
      "description": description,
      "price": price,
      "unitInStock": unitInStock,
      "category": category,
      "image": image,
      "isliked": isLiked,
      "isSelected": isSelected
    };
  }

  static void getAllTheProduct() async {
    Map<dynamic, dynamic> valuesMap;
    Product.listOfAllProduct = new List<Product>();

    await productRef.once() .then(  (n){

       if (n.value != null) {
        valuesMap = n.value;

        try {
        valuesMap.forEach( (key, value) {

           Product.listOfAllProduct.add(

             Product.fromMap(
                  productID:   key,
                  image:          value["image"],
                  price:          double.parse(value["price"].toString()),
                  isSelected:     value["isSelected"],
                  name:           value["name"],     
                  description:    value["description"],
                  category:       value["category"],
                  suppliesID:     value["suppliesID"],
                  isLiked:        value["isliked"],
                  unitInStock:    value["unitInStock"],
             ));
        });
        }catch(e){
          print(e.message);
        }

      }else {
        print(n.value);
      }

    }, onError: (error) {

      print(error.message);

    } );


  }

  static Future<void> eliminarProduct(String id){
    return productRef.child(id).remove();
  } 

  static Future<void> actualizarProduct({String id, String name,String category, String description, double price, int unitInStock }){

    var toModify = {
      "name": name,
      "description": description,
      "price": price,
      "unitInStock": unitInStock,
      "category": category,
    };

    return productRef.child(id).update(toModify);
  } 

}
