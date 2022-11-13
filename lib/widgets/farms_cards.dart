import 'package:agrivillage_users_app/models/farm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/sellers.dart';
import 'farm_card_design.dart';

class farms_cards extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  farms_cards({this.model, this.context});
  @override
  State<farms_cards> createState() => _farms_cardsState();
}

class _farms_cardsState extends State<farms_cards> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 230,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(widget.model!.sellerUID)
            .collection("firmVisit")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Farm fmodel = Farm.fromJson(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                );
                return farm_card_design(
                  model: fmodel,
                  context: context,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
