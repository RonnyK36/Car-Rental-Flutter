import 'package:e_shop/Store/garage.dart';
import 'package:e_shop/Counters/cartItemCounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ReusableAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  ReusableAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
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
      centerTitle: true,
      title: Text(
        'Car Ride',
        style: TextStyle(
          fontFamily: "Signatra",
          fontSize: 55,
        ),
      ),
      bottom: bottom,
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => MyGarage());
                Navigator.pushReplacement(context, route);
              },
              icon: Icon(
                Icons.add_shopping_cart_sharp,
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
    );

  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
