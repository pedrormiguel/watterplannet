import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/screen/home/title_text.dart';
import 'package:watterplannet/theme/light_color.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Product model;
  @override
  void initState() {
    model = widget.product;
    super.initState();
  }

   

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('detail',arguments: model);
        setState(() {
          // model.isSelected = !model.isSelected;
          //   AppData.productList.forEach((x) {
          //     if (x.id == model.id && x.name == model.name) {
          //       return;
          //     }
          //     x.isSelected = false;
          //   });
          //   var m = AppData.productList
          //       .firstWhere((x) => x.id == model.id && x.name == model.name);
          //   m.isSelected = !m.isSelected;
        });
      },
      child: Container(
        //  constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width , MediaQuery.of(context).size.height)),
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: !model.isSelected ? 20 : 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                    icon: Icon(
                      model.isLiked ? Icons.favorite : Icons.favorite_border,
                      color:
                          model.isLiked ? LightColor.red : LightColor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        model.isLiked = !model.isLiked;
                      });
                    })),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: model.isSelected ? 15 : 0),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: LightColor.orange.withAlpha(40),
                    ),
                    SafeArea(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(model.image)))),
                    )
                  ],
                ),
                // SizedBox(height: 5),
                AutoSizeText(
                   model.name,
                  style: TextStyle( fontSize :model.isSelected ? 16 : 14),
                ),
                AutoSizeText(
                   model.category,
                  style: TextStyle( fontSize :model.isSelected ? 14 : 12, 
                  color: LightColor.orange),
                ),
                AutoSizeText(
                  model.price.toString(),
                  style: TextStyle( fontSize : model.isSelected ? 10 : 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 
}
