import 'package:watterplannet/class/product.dart';

class ShoppingCart {
  List<Item> itemSelect = List<Item>();
}

class Item {
   Product product;
   int cuantity;

  Item({this.product, this.cuantity});
}
