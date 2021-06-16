import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a0e21),
      appBar: ReusableAppBar(),
      body: Column(
        children: [
          // Image.network(model.thumbnailUrl)
        ],
      ),
    );
  }
  Widget userInfo(UserModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    return Container(
      color: Color(0xff0a0e21),
      height: 190,
      width: MediaQuery.of(context).size.width,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
            ],
          )
        ],
      ),
    );
  }
}
