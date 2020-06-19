import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class Product 
{
  String productID;
  final String supplierID;
  final String name;
  final String description;
  final double price;
  final int unitInStock;

  //final DatabaseReference mdatabase = FirebaseDatabase.instance.reference();

  final String category;
  final String image;
  bool isLiked;
  bool isSelected;

  FirebaseDatabase database = FirebaseDatabase.instance;

  static DatabaseReference productRef =
      FirebaseData.database.reference().child('product');

  Product(
      {this.supplierID,
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
      this.supplierID,
      this.name,
      this.description,
      this.price,
      this.unitInStock,
      this.category,
      this.image,
      this.isSelected,
      this.isLiked});

  void handleSubmit() async {
    await productRef.push().set(toJson());
  }

  Product.fromSnapshot(DataSnapshot snapshot)
      : productID   = snapshot.key == null ? "" : snapshot.key,
        supplierID  = snapshot.value["supplierID"] = null ? "" : snapshot.value["supplierID"],
        name        = snapshot.value["name"],
        description = snapshot.value["description"],
        price       = double.parse(snapshot.value["price"]),
        unitInStock = int.parse(snapshot.value["unitInStock"]),
        category    = snapshot.value["category"],
        image       = snapshot.value["image"],
        isLiked     = snapshot.value["isLiked"],
        isSelected  = snapshot.value["isSelected"];
   
  toJson()
  {
    return 
    {
      "supplierID": supplierID,
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

  Future<void> updateStock(int stock) async {

    var toModify = {
      
      "unitInStock" : this.unitInStock - stock

    };

     productRef.child(this.productID).update(toModify);
   }

   Future<void> updateIsLiked() async {

     this.isLiked =  !this.isLiked;

     var toModify = {

       "isliked" : this.isLiked

     };

     productRef.child(this.productID).update(toModify);

   }

}
