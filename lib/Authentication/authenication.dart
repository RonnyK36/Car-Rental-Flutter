import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
          bottom: TabBar(
            labelColor: Colors.green,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                ),
                text: 'Login',
              ),
              Tab(
                icon: Icon(
                  Icons.person_add,
                ),
                text: 'Register',
              ),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 5,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff0a0e21),
            // gradient: LinearGradient(
            //   colors: [Color(0xff0a0e21), Color(0xff0a0e30)],
            //   begin: const FractionalOffset(0.0, 0.0),
            //   end: const FractionalOffset(1.0, 0.0),
            //   stops: [0.0, 1.0],
            //   tileMode: TileMode.clamp,
            // ),
          ),
          child: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      ),
    );
  }
}
