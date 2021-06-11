import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Store/Search.dart';

class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      InkWell(
        child: Container(
          color: Color(0xff0a0e21),
          width: MediaQuery.of(context).size.width,
          height: 80,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Route route = MaterialPageRoute(builder: (c) => SearchProduct());
              Navigator.pushReplacement(context, route);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
