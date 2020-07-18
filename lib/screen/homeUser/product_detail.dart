import 'package:flutter/material.dart';
import 'package:watterplannet/class/data.dart';
import 'package:watterplannet/class/product.dart';
import 'package:watterplannet/class/shoppingCart.dart';
import 'package:watterplannet/screen/homeUser/title_text.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:watterplannet/utils/FlushBart.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);
  Product curretItem;
  FlusBar flusBar = new FlusBar();

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  String output = "Articulo agregado al carrito";

  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  Widget _appBar(bool isLiked ) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: _icon(Icons.arrow_back_ios,
                color: Colors.black54, size: 15, padding: 12, isOutLine: true),
          ),
          InkWell(
            onTap: () async 
            {
                await widget.curretItem.updateIsLiked();
                setState(() { widget; });
            },
            child: _icon(
                widget.curretItem.isLiked
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: isLiked ? LightColor.red : LightColor.lightGrey,
                size: 15,
                padding: 12,
                isOutLine: false),
          )
        ],
      ),
    );
  }

  Widget _icon(IconData icon,
      {Color color = LightColor.iconColor,
      double size = 20,
      double padding = 10,
      bool isOutLine = false}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SafeArea(
              child: Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.network(
                    widget.curretItem.image,
                    loadingBuilder: (context, child , progress) {
                      return progress == null
                      ? child
                      : LinearProgressIndicator();
                    },
                    ),
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         fit: BoxFit.contain,
                  //         image: NetworkImage(widget.curretItem.image, )))
                  
                  ))
          //
        ],
      ),
    );
  }




  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText(widget.curretItem.name,
                          style: TextStyle(fontSize: 25)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\$ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                text: widget.curretItem.price.toString(),
                                fontSize: 25,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star_border, size: 17),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // _availableSize(),
                // SizedBox(
                //   height: 20,
                // ),
                // _availableColor(),
                SizedBox(
                  height: 20,
                ),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }


 

  


  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        AutoSizeText(
          widget.curretItem.description,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void addToListCart(Product model) {
  
      Item itemSelecte = Item(product: model, cuantity: 1);
      bool hasItem = false;

      for (var i = 0; i < AppData.cartList.itemSelect.length; i++) {
        String id = AppData.cartList.itemSelect.elementAt(i).product.productID;

        if (id == model.productID) {
            AppData.cartList.itemSelect.elementAt(i).cuantity ++;  
            hasItem != hasItem;
        return;
        }
      }

      if(!hasItem)
      AppData.cartList.itemSelect.add(itemSelecte);
      int position =  AppData.cartList.itemSelect.length - 1;
      AppData.cartList.itemSelect.elementAt(position).positionList = position;
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {
        addToListCart(widget.curretItem);
        widget.flusBar
            .getBar(context: context, title: 'Notificacion', message: output);
      },
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {

    widget.curretItem = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(widget.curretItem.isLiked),
                  _productImage(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}
