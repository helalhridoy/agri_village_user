import 'package:agrivillage_users_app/assistantMethods/assistant_methods.dart';
import 'package:agrivillage_users_app/models/items.dart';
import 'package:agrivillage_users_app/widgets/items_card_design.dart';
import 'package:agrivillage_users_app/widgets/my_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap_widget/gap_widget.dart';

import '../app_styles.dart';
import '../models/sellers.dart';
import '../widgets/farms_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = [
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
  ];

  @override
  void initState() {
    super.initState();

    clearCartNow(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
        title: const Text(
          "AgriVillage",
          style: TextStyle(fontSize: 30, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        // Optional
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .2,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayCurve: Curves.decelerate,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: items.map((index) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: const BoxDecoration(
                          //color: Colors.green,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          index,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
            VerticalGap(gap: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Farms',
                      style: Styles.headLineStyle2,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        print("Tapped");
                      },
                      child: Text(
                        'View all',
                        style: Styles.textStyle
                            .copyWith(color: Styles.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            VerticalGap(gap: 15),
            Container(
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("sellers")
                    .snapshots(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Sellers sModel = Sellers.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          //design for display sellers-cafes-restuarents
                          return farms_cards(
                            model: sModel,
                            context: context,
                          );
                        }),
                  );
                },
              ),
            ),
            VerticalGap(gap: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Products',
                      style: Styles.headLineStyle2,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        print("Tapped");
                      },
                      child: Text(
                        'View all',
                        style: Styles.textStyle
                            .copyWith(color: Styles.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            VerticalGap(gap: 15),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("items")
                    .orderBy("publishedDate", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Items sModel = Items.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return item_cards_design(
                            model: sModel,
                            context: context,
                          );
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
