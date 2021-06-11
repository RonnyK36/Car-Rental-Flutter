import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/garage.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
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
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(80),
                  ),
                  elevation: 8,
                  child: Container(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(CarRideApp.sharedPreferences
                          .getString(CarRideApp.userAvatarUrl),),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  CarRideApp.sharedPreferences.getString(CarRideApp.userName),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'Signatra'),
                ),
                Text(
                  CarRideApp.sharedPreferences.getString(CarRideApp.userEmail),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Signatra'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.only(top: 1),
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
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => StoreHome());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 5,
                  color: Colors.white,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.white,
                  ),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 5,
                  color: Colors.white,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  title: Text(
                    'My Cart',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => MyGarage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 5,
                  color: Colors.white,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 5,
                  color: Colors.white,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_location,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Add new Address',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AddAddress());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 5,
                  color: Colors.white,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    CarRideApp.auth.signOut().then((c){
                      Route route =
                      MaterialPageRoute(builder: (c) => AuthenticScreen() );
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                // Divider(
                //   height: 30,
                //   color: Colors.white,
                //   thickness: 1,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
