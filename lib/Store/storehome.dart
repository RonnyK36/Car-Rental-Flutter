import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/garage.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff0a0e21), Color(0xff0a0e30)],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
              color: Color(0xff0a0e21),
            ),
          ),
          title: Text(
            'Car Ride',
            style: TextStyle(
              fontFamily: "Signatra",
              fontSize: 55,
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (c) => MyGarage());
                    Navigator.pushReplacement(context, route);
                  },
                  icon: Icon(
                    Icons.car_rental,
                    color: Colors.green,
                  ),
                ),
                Positioned(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20,
                        color: Colors.white,
                      ),
                      Positioned(
                        top: 3,
                        bottom: 4,
                        child:  Consumer<CartItemCounter>(
                          builder: (context, counter, _){
                            return Text(
                              counter.count.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }
                        ),),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Text('You are logged in'),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell();
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
