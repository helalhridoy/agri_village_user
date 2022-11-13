import 'package:agrivillage_users_app/models/farm.dart';
import 'package:agrivillage_users_app/widgets/farm_design_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/my_drawer.dart';

class farm_profile extends StatefulWidget {
  //const farm_profile({Key? key, this.model}) : super(key: key);

  final Farm? model;
  BuildContext? context;
  farm_profile({Key? key, this.model, this.context}) : super(key: key);

  @override
  State<farm_profile> createState() => _farm_profileState();
}

class _farm_profileState extends State<farm_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.green,
        ),
        title: Text(
          widget.model!.farmName!.toString(),
          style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: farm_design_widget(
        model: widget.model,
        context: context,
      ),
    );
  }
}
