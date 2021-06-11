import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController =
      TextEditingController();
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
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
        leading: IconButton(
          icon: Icon(
            Icons.border_color,
            color: Colors.white,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (c) => SplashScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
            child: Text(
              'Log out',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: getAdminScreen(),
    );
  }

  getAdminScreen() {
    return Container(
      color: Color(0xff0a0e21),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              color: Colors.white,
              size: 200,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Text(
                  'Add new items',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  //  get new image
                  getImage(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              'Item image',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  'Take a picture',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  capturePhoto();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Select from gallery',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  getFromGallery();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  capturePhoto() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 680,
      maxWidth: 970,
    );
    setState(() {
      file = imageFile;
    });
  }

  getFromGallery() async {
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Color(0xff0a0e21),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            clearForm();
          },
        ),
        title: Text(
          'New product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed:
              uploading ? null : ()=> uploadItem(),
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(''),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _shortInfoTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Short info',
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xff0a0e21),
          ),ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _titleTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xff0a0e21),
          ),ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xff0a0e21),
          ),ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _priceTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xff0a0e21),
          ),
        ],
      ),
    );
  }

  clearForm() {
    setState(() {
      file=null;
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortInfoTextEditingController.clear();
    });
  }
  uploadItem() async {
    setState(() {
      uploading = true;
    });
    String imageDownloadUrl = await uploadImage(file);
    saveItemInfo(imageDownloadUrl);
  }
  Future<String> uploadImage(mFileImage) async {
    final StorageReference storageReference = FirebaseStorage.instance.ref().child('Items');
    StorageUploadTask uploadTask = storageReference.child('product_$productId.jpg').putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;

  }
  saveItemInfo(String downloadUrl){
    final itemsRef = Firestore.instance.collection('items');
    itemsRef.document(productId).setData({
      'shortInfo': _shortInfoTextEditingController.text.trim(),
      'longDescription': _descriptionTextEditingController.text.trim(),
      'price': int.parse(_priceTextEditingController.text),
      'publishDate': DateTime.now(),
      'status': 'available',
      'thumbnailUrl': downloadUrl,
      'title': _titleTextEditingController.text.trim(),
    });
    setState(() {
      file = null;
      uploading = false;
      productId =DateTime.now().microsecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
    });
  }
}
