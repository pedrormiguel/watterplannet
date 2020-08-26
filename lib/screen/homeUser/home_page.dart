import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/homeUser/product_icon.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';
import 'package:watterplannet/utils/Sizes/SizesConfi.dart';

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
  

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .6,
      child: gridSystemBuild(context),
    );
  }

  Widget _productCars(List<Product> listOfAllProduct) {

    SizeConfig().init(context);

    return Container
    (

          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          margin: EdgeInsets.all(5),

      child: GFCarousel
      (
        aspectRatio: 4/3,
        height: SizeConfig.blockSizeVertical * 100,
        activeIndicator: Colors.green,
        passiveIndicator: Colors.blue,
        pagination: true,
        //autoPlay: true,
        pauseAutoPlayOnTouch: Duration(seconds: 5),
        autoPlayInterval: Duration(seconds: 5),
        items: listOfAllProduct.map
        (
          (url) 
          {
            return Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration
              (
                  color: Colors.white,
                  borderRadius: BorderRadius.only
                    (
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    
                    boxShadow: 
                  [
                          BoxShadow
                          (
                            color: Colors.blueGrey.withOpacity(.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(-1, 3), // changes position of shadow
                          ),
                   ],
              ),
              child: GFCard
              (
                elevation: 3.0,
                
                height: SizeConfig.blockSizeVertical * 100,
                borderOnForeground: true,
                  boxFit: BoxFit.cover,
                  image: Image.network
                    (
                        url.image,
                        fit: BoxFit.cover, 
                        filterQuality: FilterQuality.medium,
                          height: SizeConfig.getSizeFromScreenHeight(),
                          //height: SizeConfig.blockSizeVertical * 60,
                          width: SizeConfig.blockSizeHorizontal * 100,
                        loadingBuilder: (context, child, progress)
                        {
                          return progress == null
                              ? child
                              : Container
                              (
                                height: SizeConfig.getSizeFromScreenHeight(),
                                width: SizeConfig.blockSizeHorizontal * 100,
                                child: Center
                                (
                                  child: CircularProgressIndicator
                                  (
                                    strokeWidth: 50,
                                      value: progress.expectedTotalBytes != null
                                          ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes
                                          : null
                                  ),
                                ),
                              );
                        }
                    ),
                  titlePosition: GFPosition.start ,
                  
                  title: GFListTile
                  (
                      title: Text(url.name ,style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5),),
                      icon: GFIconButton
                      (
                          onPressed: () => Navigator.of(context).pushNamed('detail', arguments: url),
                          icon: Icon(Icons.arrow_forward, size:  SizeConfig.safeBlockHorizontal * 5  ),
                          type: GFButtonType.transparent,
                      )
                  ),
                  content: AutoSizeText(url.category,  wrapWords: true,style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5))
              ),
            );
          },
        ).toList(),
        
      ),
    );
  }


  Widget gridSystemBuild(BuildContext context) {
    return Container(
       
        child: StreamBuilder
        (
            stream: Product.productRef.onValue,
            builder: (context, AsyncSnapshot snapshot) 
            {
              var grade = snapshot.connectionState.toString();

              switch (grade) 
              {
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

                  var listOfAllProduct = List<Product>();

                  values.forEach((key, value) 
                  {
                    if (value["unitInStock"] > 0)
                      listOfAllProduct.add(Product.fromMap(
                          productID: key,
                          image: value["image"],
                          price: double.parse(value["price"].toString()),
                          isSelected: value["isSelected"],
                          name: value["name"],
                          description: value["description"],
                          category: value["category"],
                          supplierID: value["supplierID"],
                          isLiked: value["isliked"],
                          unitInStock: value["unitInStock"]));
                  });

                  return listOfAllProduct.length <= 0 
                         ? withOutProduct() 
                         :  _productCars(listOfAllProduct);
                  break;

                default:
                  return Text("data :");
                  break;
              }
            }));
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Container
      (
        child: gridSystemBuild(context),
      ),
    );
  }

    Widget withOutProduct() {
    return Center(
        child: AutoSizeText(
      "No hay articulos, aun",
      maxFontSize: 150,
      textAlign: TextAlign.center,
      minFontSize: 25,
      maxLines: 1,
      style: TextStyle(height: 2, fontWeight: FontWeight.bold),
    ));
  }

}
