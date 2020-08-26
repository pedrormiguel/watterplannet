import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:watterplannet/class/ordenes/orderDetailProduct.dart';
import 'package:watterplannet/utils/lineSeparator.dart';

/// Example 1 folding cell inside [Container]
class FoldingCellSimpleDemo extends StatefulWidget {
  final String id, address, dateOfOrder, statusOrder;
  final Function changeToNotShowOrder;
  final List<OrderDetailProduct> orderDetailProduct;

  FoldingCellSimpleDemo(
      {Key key,
      this.address,
      this.dateOfOrder,
      this.statusOrder,
      this.changeToNotShowOrder,
      this.id,
      this.orderDetailProduct})
      : super(key: key);

  @override
  _FoldingCellSimpleDemoState createState() => _FoldingCellSimpleDemoState();
}

class _FoldingCellSimpleDemoState extends State<FoldingCellSimpleDemo> {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  double heigt = 130;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color(0xFF2e282a), borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(),
        innerWidget: _buildInnerWidget(),
        cellSize: Size(MediaQuery.of(context).size.width, heigt),
        padding: EdgeInsets.all(10),
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 10,
        onOpen: () => print('cell opened'),
        onClose: () => print('cell closed'),
      ),
    );
  }

  Widget _buildFrontWidget() {
    return Container
    (
      color: Color.fromRGBO(255, 238, 147, 1),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.address,
              style: GoogleFonts.aldrich(
                color: Color(0xFF2e282a),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 5,
            bottom: 0,
            child: Text(
              widget.dateOfOrder,
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: GFButton(
              onPressed: () {
                setState(() =>
                    heigt = (60.0 * widget.orderDetailProduct.length) + 30);
                _foldingCellKey?.currentState?.toggleFold();
              },
              child: Text("Detalles"),
              textColor: Colors.white,
              color: Color.fromRGBO(44, 102, 110, 1),
              splashColor: Colors.white.withOpacity(0.5),
            ),
          ),
          Positioned(
            left: 5,
            bottom: 0,
            child: GFButton(
              onPressed: () async =>
                  await widget.changeToNotShowOrder(widget.id),
              child: Icon(Icons.delete),
              textColor: Colors.white,
              color: Color.fromRGBO(243, 102, 110, 1),
              splashColor: Colors.white.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInnerWidget() {
    return Container
    (
      
      color: Color.fromRGBO(252, 245, 199, 1),
      ///margin: EdgeInsets.only(top:2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center
          (
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.statusOrder,
                style: GoogleFonts.aldrich(
                  color: Color(0xFF2e282a),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column
          (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.orderDetailProduct.map((item) 
              {
                  return Column
                  (
                      children: <Widget>
                      [
                        MySeparator(),
                        GFListTile(
                            avatar: Container
                            (
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(item.urlImage)
                            )
                        )),
                            titleText: item.nameProduct,
                            subtitleText: "Cantidad : ${item.amountOfUnits}",
                            description:
                                Text("SubTotal ${item.getTotalProductFormated()}")),
                        MySeparator()
                      ],
                  );
              }).toList()
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GFButtonBadge(
                  onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
                  text: getTotal(),
                  textColor: Colors.white,
                  color: Color.fromRGBO(255, 192, 159, 1),
                  splashColor: Colors.white.withOpacity(0.5),
                ),
                GFButtonBadge(
                  onPressed: () {
                    _foldingCellKey?.currentState?.toggleFold();
                     setState(() => heigt = 130);
                  },
                  text: "Close",
                  textColor: Colors.white,
                  color: Color.fromRGBO(121, 173, 220, 1),
                  splashColor: Colors.white.withOpacity(0.5),
                ),
              ])
        ],
      ),
    );
  }

  String getTotal() {
    double total = 0.0;

    for (var item in widget.orderDetailProduct) {
      setState(() {
        total = total + item.getTotalProduct();
      });
    }
    return NumberFormat.simpleCurrency().format(total);
  }
}








/// Example 2 Multiple folding cells inside [Column]
class FoldingCellMultipleCardsDemo extends StatelessWidget {
  final _foldingCellKey1 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey2 = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2e282a),
      child: Column(
        children: <Widget>[
          SimpleFoldingCell.create(
            key: _foldingCellKey1,
            frontWidget: _buildFrontWidget(_foldingCellKey1, "CARD 1"),
            innerWidget: _buildInnerWidget(_foldingCellKey1),
            cellSize: Size(MediaQuery.of(context).size.width, 140),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 10,
            onOpen: () => print('cell 1 opened'),
            onClose: () => print('cell 1 closed'),
          ),
          SimpleFoldingCell.create(
            key: _foldingCellKey2,
            frontWidget: _buildFrontWidget(_foldingCellKey2, "CARD 2"),
            innerWidget: _buildInnerWidget(_foldingCellKey2),
            cellSize: Size(MediaQuery.of(context).size.width, 125),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 10,
            onOpen: () => print('cell 2 opened'),
            onClose: () => print('cell 2 closed'),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontWidget(
      GlobalKey<SimpleFoldingCellState> key, String title) {
    return Container(
      color: Color(0xFFffcd3c),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.aldrich(
                color: Color(0xFF2e282a),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: FlatButton(
              onPressed: () => key?.currentState?.toggleFold(),
              child: Text(
                "OPEN",
              ),
              textColor: Colors.white,
              color: Colors.indigoAccent,
              splashColor: Colors.white.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInnerWidget(GlobalKey<SimpleFoldingCellState> key) {
    return Container(
      color: Color(0xFFecf2f9),
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "CARD TITLE",
              style: GoogleFonts.aldrich(
                color: Color(0xFF2e282a),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "CARD DETAIL",
              style: GoogleFonts.aldrich(
                color: Color(0xFF2e282a),
                fontSize: 40.0,
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: FlatButton(
              onPressed: () => key?.currentState?.toggleFold(),
              child: Text(
                "Close",
              ),
              textColor: Colors.white,
              color: Colors.indigoAccent,
              splashColor: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Example 3 folding cell inside [ListView]
class FoldingCellListViewDemo extends StatelessWidget {
  final String address, dateOfOrder;

  const FoldingCellListViewDemo({Key key, this.address, this.dateOfOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2e282a),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return SimpleFoldingCell.create(
            frontWidget: _buildFrontWidget(index),
            innerWidget: _buildInnerWidget(index),
            cellSize: Size(MediaQuery.of(context).size.width, 125),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 10,
            onOpen: () => print('$index cell opened'),
            onClose: () => print('$index cell closed'),
          );
        },
      ),
    );
  }

  Widget _buildFrontWidget(int index) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFFffcd3c),
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  "CARD - $index",
                  style: GoogleFonts.aldrich(
                    color: Color(0xFF2e282a),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                right: 5,
                bottom: 0,
                child: FlatButton(
                  onPressed: () {
                    final foldingCellState = context
                        .findAncestorStateOfType<SimpleFoldingCellState>();
                    foldingCellState?.toggleFold();
                  },
                  child: Text(
                    "OPEN",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildInnerWidget(int index) {
    return Builder(
      builder: (context) {
        return Container(
          color: Color(0xFFecf2f9),
          padding: EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "CARD TITLE - $index",
                  style: GoogleFonts.aldrich(
                    color: Color(0xFF2e282a),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "CARD DETAIL - $index",
                  style: GoogleFonts.aldrich(
                    color: Color(0xFF2e282a),
                    fontSize: 32.0,
                  ),
                ),
              ),
              Positioned(
                right: 5,
                bottom: 0,
                child: FlatButton(
                  onPressed: () {
                    final foldingCellState = context
                        .findAncestorStateOfType<SimpleFoldingCellState>();
                    foldingCellState?.toggleFold();
                  },
                  child: Text(
                    "Close",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
