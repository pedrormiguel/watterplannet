import 'category.dart';
import 'product.dart';

class AppData {
  static String shoe_tilt_2 = 'assets/images/shoe_tilt_2.png';
  static String shoe_tilt_1 = 'assets/images/shoe_tilt_1.png';
  static String small_tilt_shoe_1 = 'assets/images/botella.jpg';
  static String small_tilt_shoe_2 = 'assets/images/botellaM.jpg';
  static String small_tilt_shoe_3 = 'assets/images/botellon.jpg';

  static List<Product> productList = new List<Product>() ;

    static void getProduct() {
     Product.getAllTheProduct();
     productList = Product.listOfAllProduct != null ? Product.listOfAllProduct : new List<Product>();
    }

  // Lista que muestra el menu.

  // Lista que muestra los articulos del carrito.
  static List<Product> cartList = [
    Product(
        name: 'Nike Air Max 200',
        price: 240.00,
        image: small_tilt_shoe_1,
        category: "Trending Now"),
  ];

  static List<Category> categoryList = [
    Category(
        id: 1,
        name: "Sneakers",
        image: 'assets/images/shoe_thumb_2.png',
        isSelected: true),
    Category(id: 2, name: "Jacket", image: 'assets/images/jacket.png'),
    Category(id: 3, name: "Watch", image: 'assets/images/watch.png'),
    Category(id: 4, name: "Watch", image: 'assets/images/watch.png'),
  ];

  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];

  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
