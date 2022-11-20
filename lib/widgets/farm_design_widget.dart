import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_launcher/map_launcher.dart' as ml;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gl;
import 'package:agrivillage_users_app/models/farm.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:map_launcher/map_launcher.dart';
import 'dart:convert';

import 'dart:developer' as dev;
import 'package:agrivillage_users_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import '../global/global.dart';



class farm_design_widget extends StatefulWidget {
  //const farm_design_widget({Key? key}) : super(key: key);

  Farm? model;
  BuildContext? context;

  farm_design_widget({Key? key, this.model, this.context}) : super(key: key);

  @override
  State<farm_design_widget> createState() => _farm_design_widgetState();
}

enum Intent { sale, authorization }
class _farm_design_widgetState extends State<farm_design_widget> {

  Completer<gl.GoogleMapController> _controller = Completer();

  static final gl.CameraPosition _kGooglePlex = gl.CameraPosition(
    target: gl.LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );




  static final gl.CameraPosition _kLake = gl.CameraPosition(
      bearing: 192.8334901395799,
      target: gl.LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  final images = [];
    bool initState() {
      super.initState();
      focusNode = FocusNode();
    gl.CameraPosition _kGooglePlex = gl.CameraPosition(
      target: gl.LatLng(widget.model!.lat!,widget.model!.lng!),
      zoom: 14.4746,
    );


    focusNode = FocusNode();
    String intent = widget.model!.farmName!;
    images.add(widget.model!.s_img2!);
    images.add(widget.model!.s_img3!);
    images.add(widget.model!.s_img4!);
    images.add(widget.model!.s_img5!);
    return true;
  }


  Intent _intent = Intent.sale;
  FocusNode? focusNode;


  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img1!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img2!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img3!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //4th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img4!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //5th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.model!.s_img5!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
//                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  )),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 40,
                width: double.maxFinite,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    widget.model!.farmName!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GFListTile(
                titleText: "FarmDetails:",
                subTitleText: widget.model!.farmDetails!,
              ),
              GFListTile(
                titleText: "Farm Features:  ",
                subTitleText: widget.model!.farmFeatures!,
              ),
              GFListTile(
                titleText: "Farm Rules :",
                subTitleText: widget.model!.farmRules!,
              ),
              GFListTile(
                titleText: "Farm Address:  ",
                subTitleText: widget.model!.farmDetails!,
              ),
              Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  label: const Text(
                    "Open location in Map",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (await MapLauncher.isMapAvailable(ml.MapType.google) ??
                        false) {
                      await MapLauncher.showMarker(
                        mapType: ml.MapType.google,
                        coords: Coords(widget.model!.lat!, widget.model!.lng!),
                        title: widget.model!.farmName.toString(),
                        description: widget.model!.farmDetails,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 400,
                alignment: Alignment.center,
                child:gl.GoogleMap(
                  mapType:  gl.MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (gl.GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),

              ),
              GFListTile(
                titleText: "Visiting Hour:",
                subTitleText: widget.model!.farmTiming!,
              ),
              GFListTile(
                titleText: "Farm Charges:",
                subTitleText: widget.model!.farmCharges!.toString(),
              ),
              GFListTile(
                titleText: "Farm Status:",
                subTitleText: widget.model!.status!,
              ),
              Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        backgroundColor: Colors.green),
                    child: Text(
                      "Pay "+widget.model!.farmCharges!.toString()+" Taka with Bkash",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      String amount = widget.model!.farmCharges!;
                      String intent ="sale";
                      // String intent =
                      // //_intent == Intent.sale ? "sale" : "authorization";

                      if (amount.isEmpty) {
                        // if the amount is empty then show the snack-bar
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Amount is empty. Without amount you can't pay. Try again")));
                        return;
                      }
                      // remove focus from TextField to hide keyboard
                      focusNode!.unfocus();
                      // Goto BkashPayment page & pass the params
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BkashPayment(
                            /// depend isSandbox (true/false)
                            isSandbox: true,

                            /// amount of your bkash payment
                            amount: amount,

                            /// intent would be (sale / authorization)
                            intent: intent,
                            // accessToken: '', /// if the user have own access token for verify payment
                            // currency: 'BDT',
                            /// bkash url for create payment, when you implement on you project then it be change as your production create url, [when you send it on sandbox mode, send it as empty string '' or anything]
                            createBKashUrl:
                            'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',

                            /// bkash url for execute payment, , when you implement on you project then it be change as your production create url, [when you send it on sandbox mode, send it as empty string '' or anything]
                            executeBKashUrl:
                            'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',

                            /// for script url, when you implement on production the set it live script js (https://scripts.pay.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-pay.js)
                            scriptUrl:
                            'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',

                            /// the return value from the package
                            /// status => 'paymentSuccess', 'paymentFailed', 'paymentError', 'paymentClose'
                            /// data => return value of response
                            paymentStatus: (status, data) {
                              dev.log('return status => $status');
                              dev.log('return data => $data');

                              /// when payment success
                              if (status == 'paymentSuccess') {
                                if (data['transactionStatus'] == 'Completed') {
                                  Style.basicToast('Payment Success');

                                  saveInfo() {
                                    final ref = FirebaseFirestore.instance
                                        .collection("sellers")
                                        .doc(widget.model!.sellerUID)
                                        .collection("firmVisit");

                                    ref.doc(uniqueIdName).set({
                                      "userName": sharedPreferences!.getString("name"),
                                      "userEmain": sharedPreferences!.getString("email"),
                                      "userUid": sharedPreferences!.getString("uid"),

                                    }).then((value) {
                                      final itemsRef = FirebaseFirestore.instance
                                          .collection("sellers")
                                          .doc(widget.model!.sellerUID)
                                          .collection("firmVisit");

                                      itemsRef.doc(uniqueIdName).set({
                                        "userName": sharedPreferences!.getString("name"),
                                        "userEmain": sharedPreferences!.getString("email"),
                                        "userUid": sharedPreferences!.getString("uid"),
                                      });
                                    }).then((value) {


                                      setState(() {
                                        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

                                      });
                                    });
                                  }


                                }
                              }

                              /// when payment failed
                              else if (status == 'paymentFailed') {
                                if (data.isEmpty) {
                                  Style.errorToast('Payment Failed');
                                } else if (data[0]['errorMessage'].toString() !=
                                    'null') {
                                  Style.errorToast(
                                      "Payment Failed ${data[0]['errorMessage']}");
                                } else {
                                  Style.errorToast("Payment Failed");
                                }
                              }

                              // when payment on error
                              else if (status == 'paymentError') {
                                Style.errorToast(
                                    jsonDecode(data['responseText'])['error']);
                              }

                              // when payment close on demand closed the windows
                              else if (status == 'paymentClose') {
                                if (data == 'closedWindow') {
                                  Style.errorToast(
                                      'Failed to payment, closed screen');
                                } else if (data == 'scriptLoadedFailed') {
                                  Style.errorToast(
                                      'Payment screen loading failed');
                                }
                              }
                              // back to screen to pop()
                              Navigator.of(context).pop();
                            },
                          )));
                    },
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
