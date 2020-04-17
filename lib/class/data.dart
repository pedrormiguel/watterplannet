import 'category.dart';
import 'product.dart';

class AppData {
  // Lista que muestra el menu.
  static List<Product> productList = [

    Product(
        productID: 1.toString(), 
        name: 'Nike Air Max 200',
        price: 240.00,
        image: 'assets/shooe_tilt_1.png',
        category: "Trending Now"),

    Product(
        productID: 2.toString(),
        name: 'Nike Air Max 97',
        price: 220.00,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),

  ];
  // Lista que muestra los articulos del carrito.
  static List<Product> cartList = [
    Product(
        productID: 1.toString(),
        name: 'Nike Air Max 200',
        price: 240.00,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),

    Product(
        productID: 2.toString(),
        name: 'Nike Air Max 97',
        price: 190.00,
        image: 'assets/small_tilt_shoe_2.png',
        category: "Trending Now"),

    Product(
        productID: 1.toString(),
        name: 'Nike Air Max 92607',
        price: 220.00,
        image: 'assets/small_tilt_shoe_3.png',
        category: "Trending Now"),

     Product(
        productID: 3.toString(),
        name: 'Nike Air Max 200',
        price: 240.00,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),
  ];

  static List<Category> categoryList = [
    Category(),
    Category(id:1,name: "Sneakers",image: 'assets/shoe_thumb_2.png',isSelected: true),
    Category(id:2,name: "Jacket", image: 'assets/jacket.png'),
    Category(id:3,name: "Watch", image: 'assets/watch.png'),
    Category(id:4,name: "Watch", image: 'assets/watch.png'),
  ];

  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];

  static String description = "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
