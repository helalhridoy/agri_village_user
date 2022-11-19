import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assistantMethods/assistant_methods.dart';
import '../mainScreens/item_detail_screen.dart';
import '../models/items.dart';

class item_cards_design extends StatefulWidget {
  Items? model;
  BuildContext? context;

  item_cards_design({this.model, this.context});

  @override
  State<item_cards_design> createState() => _item_cards_designState();
}

class _item_cards_designState extends State<item_cards_design> {
  late String name;
  late String price;
  late String imgPath;
  late bool added;
  late bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    name = widget.model!.title.toString();
    price = widget.model!.price.toString();
    imgPath = widget.model!.thumbnailUrl.toString();
    added = false;
    isFavorite = false;
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0, right: 0.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ItemDetailsScreen(model: widget.model)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                                : Icon(Icons.favorite_border,
                                    color: Color(0xFFEF7532))
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 100.0,
                          width: 240.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imgPath),
                                  fit: BoxFit.cover)))),
                  SizedBox(height: 7.0),
                  Text(price,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        int itemCounter = 1;

                        List<String> separateItemIDsList = separateItemIDs();

                        //1.check if item exist already in cart
                        separateItemIDsList.contains(widget.model!.itemID)
                            ? Fluttertoast.showToast(
                                msg: "Item is already in Cart.")
                            :
                            //2.add to cart
                            addItemToCart(
                                widget.model!.itemID, context, itemCounter);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.lime,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        )),
                        width: MediaQuery.of(context).size.width - 13,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]))));
  }
}
