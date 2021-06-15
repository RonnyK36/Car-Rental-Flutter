import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartItemCounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'garageItems.dart';

class MyGarage extends StatefulWidget {
  final ItemModel itemModel;

  MyGarage({this.itemModel});
  @override
  _MyGarageState createState() => _MyGarageState();
}

class _MyGarageState extends State<MyGarage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('New'),
          ],
        ),
      ),
      body: Text(widget.itemModel.title),
    );
  }
}

