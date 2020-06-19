import 'package:flutter/material.dart';
import 'package:watterplannet/class/category.dart';
import 'package:watterplannet/screen/homeUser/title_text.dart';
import 'package:watterplannet/theme/light_color.dart';
import 'package:watterplannet/theme/theme.dart';

class ProducIcon extends StatelessWidget {
 
  final Category model;
  ProducIcon({Key key, this.model}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: AppTheme.hPadding,
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: model.isSelected ? LightColor.background : Colors.transparent,
        border: Border.all(
            color: model.isSelected ? LightColor.orange : LightColor.grey,
            width: model.isSelected ? 2 : 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: model.isSelected ? Color(0xfffbf2ef) : Colors.white,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.09,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain, image: AssetImage(model.image)))),
          ),
          Container(
            child: TitleText(
              text: model.name,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
