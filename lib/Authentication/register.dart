import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    //get screen size
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10,
            ),
            //User select image ?
            InkWell(
              onTap: () {
                _selectImage();
              },
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                //set image if selected
                backgroundImage:
                    _imageFile == null ? null : FileImage(_imageFile),
                //if no image selected
                child: _imageFile == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: _screenWidth * 0.15,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameEditingController,
                    data: Icons.person,
                    hintText: "Enter your name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailEditingController,
                    data: Icons.email,
                    hintText: "Enter your email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _confirmPasswordEditingController,
                    data: Icons.person,
                    hintText: "Confirm password",
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
                uploadImage();
              },
              child: Text("Sign up"),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 2.0,
              color: Colors.blueGrey,
              width: _screenWidth * 0.9,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: 'Please select a profile picture.',
            );
          });
    } else {
      _passwordEditingController.text == _confirmPasswordEditingController.text
          ? _emailEditingController.text.isNotEmpty &&
                  _passwordEditingController.text.isNotEmpty &&
                  _confirmPasswordEditingController.text.isNotEmpty &&
                  _nameEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please check your details again")
          : displayDialog("Passwords do not match.");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Creating your account, Please wait...",
          );
        });
    String imageFilename = DateTime.now().microsecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFilename);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
      email: _emailEditingController.text.trim(),
      password: _passwordEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      saveUserInfo(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => ShowRoom());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfo(FirebaseUser fUser) async {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      'name': _nameEditingController.text.trim(),
      "url": userImageUrl,
      CarRideApp.userCollectionList: ["garbageValue"],
    });
    await CarRideApp.sharedPreferences.setString('uid', fUser.uid);
    //alt way to get
    await CarRideApp.sharedPreferences
        .setString(CarRideApp.userName, _nameEditingController.text);
    await CarRideApp.sharedPreferences
        .setString(CarRideApp.userEmail, fUser.email);
    // await CarRideApp.sharedPreferences
        // .setString(CarRideApp.userName, fUser.displayName);
    await CarRideApp.sharedPreferences
        .setString(CarRideApp.userAvatarUrl, userImageUrl);
    await CarRideApp.sharedPreferences
        .setStringList(CarRideApp.userCollectionList, ["garbageValue"]);
  }
}
