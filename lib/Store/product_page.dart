import 'package:e_shop/Counters/cartItemCounter.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/reusableDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';

import 'garage.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;

  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;
  // Future<bool> _onBackPressed(){
  //   Route route = MaterialPageRoute(builder: (c) => StoreHome());
  //   return Navigator.pushReplacement(context, route);
  // }

  // Future<bool> _onBackPressed(){
    //trying to handle the backPressed issue
    // return showDialog(context: context, builder: (c)=> AlertDialog(
    //   title: Text('Do you want to leave the show room.'),
    //   actions: [
    //     TextButton(
    //       onPressed: (){
    //         Route route = MaterialPageRoute(builder: (c)=>StoreHome());
    //         Navigator.pushReplacement(context, route);
    //       },
    //       child: Text('Yes'),
    //     ),
    //     TextButton(onPressed: (){
    //       Navigator.pop(context);
    //     }, child: Text('No'))
    //   ],
    // ));
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: back,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c)=>StoreHome());
                Navigator.push(context, route);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,),
            ),
            centerTitle: true,
            title: Text(
              'Car Ride',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 55,
              ),
            ),
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
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
          // drawer: ReusableDrawer(),
          body: ListView(

            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.network(widget.itemModel.thumbnailUrl),
                        ),
                        Container(
                          color: Colors.grey[400],
                          child: SizedBox(
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemModel.title,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.itemModel.longDescription,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Kshs " + widget.itemModel.price.toString(),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Center(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff0a0e21), Color(0xff0a0e30)],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                              // color: Color(0xff0a0e21),
                            ),
                            width: MediaQuery.of(context).size.width - 40,
                            height: 50,
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: (){
                                    checkItemInCart(widget.itemModel.shortInfo, context);
                                  },
                                  child: Text(
                                    'Add to Garage',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    Route route = MaterialPageRoute(builder: (c) => StoreHome());
                                    Navigator.pushReplacement(context, route);
                                  },
                                  child: Text(
                                    'Back to ShowRoom',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void back(){
    Navigator.pop(context);
  }
}


const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
