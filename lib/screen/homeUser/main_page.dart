import 'package:flutter/material.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/screen/homeUser/home_page.dart';
import 'package:watterplannet/screen/homeUser/orderList.dart';
import 'package:watterplannet/screen/homeUser/shopping_cart_page.dart';
import 'package:watterplannet/utils/drawer/drawerMenu.dart';
import 'package:watterplannet/utils/drawer/drawerOptions.dart';

class MainPage extends StatefulWidget {
  MainPage(this.title);
  static User user;
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

      PageController _pageController;
      int _page = 0;


      @override
      void initState() {
        super.initState();
        _pageController = new PageController();
      }

      @override
      void dispose() {
        super.dispose();
        _pageController.dispose();
      }

       void navigationTapped(int page) {
        // Animating to the page.
        // You can use whatever duration and curve you like
       _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
       }

         void onPageChanged(int page) {
          setState(() {
            this._page = page;
          });
        }


  @override
  Widget build(BuildContext ctn) {
    MainPage.user = ModalRoute.of(context).settings.arguments;

    List<DrawerOptions> draweOptions = [];

    draweOptions.add(new DrawerOptions(
      title: "Carrito de Compras",
      icon: Icon(Icons.filter_none),
      function: () => Navigator.pushNamed(ctn, 'shopingCart'),
    ));

    draweOptions.add(new DrawerOptions(
      title: "Cerrar sesion",
      icon: Icon(Icons.exit_to_app),
      function: () => Navigator.pushReplacementNamed(ctn, '/'),
    ));

    DraweMenu draweMenu = new DraweMenu(
      user: MainPage.user,
      drawerOptions: draweOptions,
    );

      return Scaffold
      (
        drawer: draweMenu,
        appBar: AppBar(title: Text(widget.title)),
        body: PageView(
          children: <Widget>[HomePage(), ShopingCartPage("Carrito de Compra"), OrderList()],
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: Theme( 
               data: Theme.of(context).copyWith(
                 canvasColor: Color(0xFF167F67)
               ),
               child: bottomBar() ),
      );
  }

 BottomNavigationBar bottomBar() =>
        BottomNavigationBar(
                  items: [

                    new BottomNavigationBarItem(
                        icon: new Icon(
                          Icons.home,
                          color: const Color(0xFFFFFFFF),
                        ),
                        title: new Text(
                          "Home",
                          style: new TextStyle(
                            color: const Color(0xFFFFFFFF),
                          ),
                        )),

                    new BottomNavigationBarItem(
                        icon: new Icon(
                          Icons.shopping_basket,
                          color: const Color(0xFFFFFFFF),
                        ),
                        title: new Text(
                          "Carrito",
                          style: new TextStyle(
                            color: const Color(0xFFFFFFFF),
                          ),
                        )),

                    new BottomNavigationBarItem(
                        icon: new Icon(
                          Icons.local_offer,
                          color: const Color(0xFFFFFFFF),
                        ),
                        title: new Text(
                          "Ordenes",
                          style: new TextStyle(
                            color: const Color(0xFFFFFFFF),
                          ),
                        ))
                  ],
                  onTap: navigationTapped,
                  currentIndex: _page,
                  selectedItemColor: Colors.red,
                );


}
