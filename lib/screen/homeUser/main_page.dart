import 'package:flutter/material.dart';
import 'package:watterplannet/class/usuarios/user.dart';
import 'package:watterplannet/screen/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:watterplannet/screen/homeUser/home_page.dart';
import 'package:watterplannet/screen/homeUser/orderList.dart';
import 'package:watterplannet/screen/homeUser/shopping_cart_page.dart';
import 'package:watterplannet/screen/homeUser/title_text.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';
import 'package:watterplannet/utils/drawerMenu.dart';
import 'package:watterplannet/utils/drawerOptions.dart';

class MainPage extends StatefulWidget {

  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  static int selectWidget = 0;
  Widget p ;

  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset('assets/images/user.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return InkWell(
      onTap: () {
          _scaffoldKey.currentState.openDrawer();
      },
          child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: Theme.of(context).backgroundColor,
            boxShadow: AppTheme.shadow),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: isHomePageSelected ? 'Our' : 'Shopping',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: isHomePageSelected ? 'Products' : 'Cart',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Spacer(),
            !isHomePageSelected
                ? Icon(
                    Icons.delete_outline,
                    color: LightColor.orange,
                  )
                : SizedBox()
          ],
        ));
}

  void onBottomIconPressed(int index) {

    if (index == 0 ) 
    {
      setState(() {
         widget.p = HomePage();
        isHomePageSelected = true;
      });
    } else if(index == 1) 
    {
      setState(() {
        widget.p = ShopingCartPage();
        isHomePageSelected = false;
      });
    } else if( index ==2 ) 
    {
      setState(() {
        widget.p = OrderList();
      });
    }
    else 
      setState(() 
      {
        widget.p = Text('PAGE 3');
      });

  }

  @override
  Widget build(BuildContext ctn) 
  {

      User user = ModalRoute.of(context).settings.arguments;


      List<DrawerOptions> draweOptions = [];

    draweOptions.add
    (
       new DrawerOptions
           (
              title:"Carrito de Compras"   ,
              icon:Icon(Icons.filter_none) ,
              function: () => Navigator.pushNamed(ctn, 'shopingCart'), 
           )
    );

    draweOptions.add
    (
       new DrawerOptions
         ( 
            title:"Cerrar sesion",
            icon:Icon(Icons.exit_to_app),
           function: () => Navigator.pushReplacementNamed(ctn, '/'), 
         )
    );

     DraweMenu draweMenu = new DraweMenu 
    (
      user: user,
      drawerOptions: draweOptions ,

    );


    return Scaffold
    (
      key: _scaffoldKey,
      drawer: draweMenu,
      body: SafeArea 
      (
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView
            (
              child: Container
              (
                height: AppTheme.fullHeight(context) ,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                 begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    _appBar() ,
                    _title()  ,
                    Expanded
                    (
                        child: AnimatedSwitcher
                        (
                            duration: Duration(milliseconds: 300),
                            switchInCurve: Curves.easeInToLinear,
                            switchOutCurve: Curves.easeOutBack,
                            child: widget.p == null ? HomePage() : widget.p,
                        )
                    )
                  ],
                ),
              ),
            ) 
            ,
            Positioned
            (
                bottom: 0,
                right:  0,
                child: CustomBottomNavigationBar
                (
                  key: context.widget.key,
                  onIconPresedCallback: onBottomIconPressed,
                )
            )
          ],
        ),
      ),
    );
  }

}
