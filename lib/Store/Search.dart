
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/garage.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/customAppBar.dart';

class SearchService {
}



class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}



class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: ReusableAppBar(),
    ),
    );
  }
  void back (){
    Navigator.pop(context);
  }
}

Widget buildResultCard(data) {
  return MyGarage();

}
