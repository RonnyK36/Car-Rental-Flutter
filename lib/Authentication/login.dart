import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //get screen size
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double _screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/login.png',
                width: 200,
                height: 200,
              ),
              padding: EdgeInsets.all(10),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Log in now.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailEditingController,
                    data: Icons.email,
                    hintText: "eg ronny@gmail.com",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.purple,
                ),
              ),
              onPressed: () {
                _emailEditingController.text.isNotEmpty &&
                    _passwordEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                    context: context,
                    builder: (c) {
                      return ErrorAlertDialog(
                        message: 'Please enter email and password',
                      );
                    });
              },
              onLongPress: () {},
              child: Text("Log in"),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 2.0,
              color: Colors.blueGrey,
              width: _screenWidth * 0.9,
            ),
            TextButton(
              onPressed: () =>
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => AdminSignInPage())),
              child: Row(
                children: [
                  Icon(
                    Icons.nature_people,
                    color: Colors.green,
                  ),
                  Text('Log in as Admin'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(context: context, builder: (c) {
      return LoadingAlertDialog(message: "Logging you in",);
    });
    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(
      email: _emailEditingController.text.trim(),
      password: _passwordEditingController.text.trim(),).then((authUser) {
        firebaseUser = authUser.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null)
      {
        readData(firebaseUser).then((s){
          Navigator.pop(context);
          Route route = MaterialPageRoute(builder: (c) => StoreHome());
          Navigator.pushReplacement(context, route);
        });
      }
  }
  Future readData(FirebaseUser fUser)async{
    Firestore.instance.collection("users").document(fUser.uid).get().then((dataSnapShot) async {
      await CarRideApp.sharedPreferences.setString('uid', dataSnapShot.data[CarRideApp.userUID]);
      //alt way to get
      await CarRideApp.sharedPreferences
          .setString(CarRideApp.userEmail, dataSnapShot.data[CarRideApp.userEmail]);
      await CarRideApp.sharedPreferences
          .setString(CarRideApp.userEmail, dataSnapShot.data[CarRideApp.userName]);
      await CarRideApp.sharedPreferences
          .setString(CarRideApp.userAvatarUrl, dataSnapShot.data[CarRideApp.userAvatarUrl]);
      List<String> cartList = dataSnapShot.data[CarRideApp.userCartList].cast<String>();
      await CarRideApp.sharedPreferences
          .setStringList(CarRideApp.userCartList, ["garbageValue"]);
    });
  }
}
