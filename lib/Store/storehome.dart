import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/garage.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartItemCounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/reusableDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class ShowRoom extends StatefulWidget {
  @override
  _ShowRoomState createState() => _ShowRoomState();
}

class _ShowRoomState extends State<ShowRoom> {
  Future<bool> onBackPressed() {
    Route route = MaterialPageRoute(builder: (c) => ShowRoom());
    return Navigator.push(context, route);
  }

  Future<bool> _onBackPressed() {
    // trying to handle the backPressed issue
    return showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: Text('Do you want to leave the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          // backgroundColor: Color(0xff0a0e21),
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
                      Route route =
                          MaterialPageRoute(builder: (c) => MyGarage());
                      Navigator.push(context, route);
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
                          color: Colors.green,
                        ),
                        Positioned(
                          top: 5,
                          bottom: 5,
                          left: 7,
                          child: Consumer<CartItemCounter>(
                              builder: (context, counter, _) {
                            return Text(
                              counter.count.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          drawer: ReusableDrawer(),
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBoxDelegate(),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('items')
                    .limit(10)
                    .orderBy('publishDate', descending: true)
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  return !dataSnapshot.hasData
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: circularProgress(),
                          ),
                        )
                      : SliverStaggeredGrid.countBuilder(
                          crossAxisCount: 1,
                          staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            ItemModel model = ItemModel.fromJson(
                                dataSnapshot.data.documents[index].data);
                            return sourceInfo(model, context);
                          },
                          itemCount: dataSnapshot.data.documents.length,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
      Navigator.push(context, route);
    },
    splashColor: Color(0xff0a0e21),
    child: Container(
      color: Color(0xff0a0e21),
      height: 190,
      width: width,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Image.network(
              model.thumbnailUrl,
              filterQuality: FilterQuality.low,
              width: 130,
              height: 130,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          model.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          model.shortInfo,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    //This caused overflow, left out for future corrections
                    //Code for offers tag

                    // Container(
                    //   margin: EdgeInsets.only(left: 10),
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.rectangle,
                    //     color: Colors.green,
                    //   ),
                    //   alignment: Alignment.topLeft,
                    //   width: 40,
                    //   height: 43,
                    //   child: Center(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           '30%',
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //         ),
                    //         Text(
                    //           'off',
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Text(
                                'Original price: Kshs ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                ((model.price * 1.5).round()).toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              Text(
                                'Price per day: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Kshs ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                (model.price).toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //will be used to remove item from cart
                Flexible(
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ElevatedButton(

                          onPressed: () {
                            Route route =
                            MaterialPageRoute(builder: (c) => MyGarage());
                            Navigator.push(context, route);
                          }, child: Text('Book now')),
                    ),
                    IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: removeCartFunction == null
                          ? IconButton(
                              onPressed: () {
                                checkItemInCart(model.shortInfo, context);
                              },
                              icon: Icon(
                                Icons.car_rental,
                                color: Colors.green,
                              ),
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  color: Colors.green,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String shortInfoAsID, BuildContext context) {
  CarRideApp.sharedPreferences
          .getStringList(CarRideApp.userCollectionList)
          .contains(shortInfoAsID)
      ? Fluttertoast.showToast(msg: 'Car already in your collection')
      : addItemToCart(shortInfoAsID, context);
}

addItemToCart(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      CarRideApp.sharedPreferences.getStringList(CarRideApp.userCollectionList);
  tempCartList.add(shortInfoAsID);

  CarRideApp.firestore
      .collection(CarRideApp.collectionUser)
      .document(CarRideApp.sharedPreferences.getString(CarRideApp.userUID))
      .updateData({
    CarRideApp.userCollectionList: tempCartList,
  }).then((value) {
    Fluttertoast.showToast(msg: 'Car was added to collection');
    CarRideApp.sharedPreferences
        .setStringList(CarRideApp.userCollectionList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}

removeCartFunction(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      CarRideApp.sharedPreferences.getStringList(CarRideApp.userCollectionList);
  tempCartList.remove(shortInfoAsID);

  CarRideApp.firestore
      .collection(CarRideApp.collectionUser)
      .document(CarRideApp.sharedPreferences.getString(CarRideApp.userUID))
      .updateData({
    CarRideApp.userCollectionList: tempCartList,
  }).then((value) {
    Fluttertoast.showToast(msg: 'Car was removed from collection');
    CarRideApp.sharedPreferences
        .setStringList(CarRideApp.userCollectionList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
