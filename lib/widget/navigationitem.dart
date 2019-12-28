
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/view/classes/NavigationBar.dart';

class NavigationItem extends StatelessWidget {
  NavigationBar item;

  NavigationItem(this.item);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(item.imageUrl);
    return InkWell(
      onTap: item.onTap,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              item.imageUrl,
              height: 24,
              width:24,
              fit: BoxFit.contain,
              color: item.selected ? MColor.application : MColor.lightGreyB6,
            ),
//          SizedBox(
//            height: global.pxl5,
//          ),
//          Text(
//            item.text.toUpperCase(),
//            style: TextStyle(
//                color: item.selected ? Colors.black : lightGrey_D2,
//                fontSize: global.pxl12,
//                fontFamily: 'MontserratBold'),
//          ),
//          AnimatedOpacity(
//            duration: Duration(milliseconds: 300),
//            curve: Curves.easeIn,
//            opacity: item.selected ? 1.0 : 0.0,
//            child: Container(
//              margin: EdgeInsets.only(
//                  top: size.longestSide * .01, bottom: size.longestSide * .005),
//              height: size.longestSide * 0.007,
//              width: size.shortestSide * global.w53,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                  color: applicationColor),
//            ),
//          )
          ],
        ),
      ),
    );  }
}
