import 'package:agrivillage_users_app/mainScreens/farm_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap_widget/gap_widget.dart';

import '../app_styles.dart';
import '../models/farm.dart';

class farm_card_design extends StatefulWidget {
  Farm? model;
  BuildContext? context;
  farm_card_design({Key? key, this.model, this.context}) : super(key: key);

  @override
  State<farm_card_design> createState() => _farm_card_designState();
}

class _farm_card_designState extends State<farm_card_design> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => farm_profile(model: widget.model)));
      },
      child: Container(
        width: size * .52,
        height: 200,
        margin: EdgeInsetsDirectional.only(
          start: 20,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Expanded(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsetsDirectional.all(20),
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.model!.s_img1!),
                      ),
                    ),
                  ),
                ),
              ),
              VerticalGap(gap: 5),
              Container(
                child: Text(
                  widget.model!.farmName!,
                  style: Styles.headLineStyle2.copyWith(color: Colors.blue),
                ),
              ),
              VerticalGap(gap: 5),
              Container(
                child: Text(
                  widget.model!.farmTiming!,
                  style: Styles.headLineStyle3.copyWith(color: Colors.blue),
                ),
              ),
              VerticalGap(gap: 5),
              Container(
                child: Text(
                  widget.model!.farmCharges!,
                  style: Styles.headLineStyle4.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
