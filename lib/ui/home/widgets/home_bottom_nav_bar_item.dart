import 'package:flutter/material.dart';

class HomeBottomNavBarItem extends BottomNavigationBarItem {
  HomeBottomNavBarItem({
    required String label,
    required String activeAsset,
    required String inactiveAsset,
    double iconWidth = 20,
    double iconHeight = 20,
    double marginTop = 10,
  }) : super(
         icon: Container(
           margin: EdgeInsets.only(top: marginTop, bottom: 5),
           child: Image.asset(
             inactiveAsset,
             width: iconWidth,
             height: iconHeight,
           ),
         ),
         activeIcon: Container(
           margin: EdgeInsets.only(top: marginTop, bottom: 5),
           child: Image.asset(
             activeAsset,
             width: iconWidth,
             height: iconHeight,
           ),
         ),
         label: label,
       );
}
