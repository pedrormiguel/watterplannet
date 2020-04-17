import 'package:firebase_database/firebase_database.dart';
import 'package:watterplannet/class/FirebaseDatabase.dart';

class Product{
  final String productID;
  final String suppliesID;
  final String name ;
  final String description;
  final double price;
  final int unitInStock;

  final String category ;
  final String image ;
   bool isLiked ;
   bool isSelected ;

  final DatabaseReference productRef = FirebaseData.database.reference () .child('product');


  Product({this.productID, this.suppliesID, this.name, this.description, this.price, this.unitInStock, this.category, this.image}){
    this.isSelected = false;
    this.isLiked = false;
     handleSubmit();
  }

  void handleSubmit() async {
    print(toJson());
    await productRef.push().set(toJson());
  }

  Product.fromSnapshot( DataSnapshot snapshot)
       : productID       = snapshot.key,
         suppliesID      = snapshot.value["suppliesID"],
         name            = snapshot.value["name"],
         description     = snapshot.value["description"],
         price           = double.parse( snapshot.value["price"] ),
         unitInStock     =  int.parse( snapshot.value["unitInStock"] ),
         category        = snapshot.value["category"],
         image           = snapshot.value["image"],
         isLiked         = snapshot.value["isLiked"],
         isSelected      = snapshot.value["isSelected"];



  toJson() {
    return {
        "suppliesID"  : suppliesID,
        "name"        : name,
        "description" : description,
        "price"       : price,
        "unitInStock" : unitInStock,
        "category"    : category,
        "image"       : image,
        "isliked"     : isLiked,
        "isSelected"  : isSelected
    };
  }


}