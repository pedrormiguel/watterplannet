import 'category.dart';
import 'product.dart';

class AppData {
  static String shoe_tilt_2 = 'assets/images/shoe_tilt_2.png';
  static String shoe_tilt_1 = 'assets/images/shoe_tilt_1.png';
  static String small_tilt_shoe_1 = 'assets/images/botella.png';
  static String small_tilt_shoe_2 = 'assets/images/botellaM.png';
  static String small_tilt_shoe_3 = 'assets/images/botellon.png';

  static List<Product> productList = new List<Product>() ;

    static void getProduct() {
     Product.getAllTheProduct();
     productList = Product.listOfAllProduct != null ? Product.listOfAllProduct : new List<Product>();
    }

  // Lista que muestra el menu.

  // Lista que muestra los articulos del carrito.
  static List<Product> cartList = [];

  static List<Category> categoryList = [
    Category(
        id: 1,
        price: 20,
        name: "Sneakers",
        image: 'assets/images/shoe_thumb_2.png',
        isSelected: true),
    Category(id: 2, price: 20,name: "Jacket", image: 'assets/images/jacket.png'),
    Category(id: 3, price: 20,name: "Watch", image: 'assets/images/watch.png'),
  ];

  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];

  static String description =
      "";
}
