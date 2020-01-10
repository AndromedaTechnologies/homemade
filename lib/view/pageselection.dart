import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/stream/user/UserProviderInstance.dart';
import 'package:homemade/view/bottomnavigation/map.dart';
import 'package:homemade/view/bottomnavigation/profile.dart';
import 'package:homemade/widget/AppBarCustom.dart';
import 'package:homemade/widget/navigationitem.dart';

import 'bottomnavigation/notification.dart';
import 'classes/NavigationBar.dart';

class PageSelection extends StatefulWidget {
  @override
  _PageSelectionState createState() => _PageSelectionState();
}

class _PageSelectionState extends State<PageSelection> {
  List<NavigationBar> navigationBars = [
    NavigationBar(imageUrl: leaveBottomImage, selected: true),
    NavigationBar(imageUrl: notificationBottomImage, selected: false),
    NavigationBar(imageUrl: userBottomImage, selected: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: UserInstance.instance.scaffoldKey,
      appBar: _appbarSelection(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(navigationBars),
    );
  }

  Widget _body(){
    return navigationBars[0].selected
        ? MapView()
        : navigationBars[1].selected ? NotificationView() : ProfileView();
  }

  Widget _appbarSelection() {
    return navigationBars[0].selected
        ? null
        : navigationBars[1].selected ? null : AppBarCustom("My Account");
  }

  Widget _bottomNavigationBar(List<NavigationBar> navigations) {
    Size size = MediaQuery.of(context).size;

    List<Widget> _navigationItem = [];
    navigations.forEach((item) => _navigationItem.add(NavigationItem(item
      ..setOnTab(() {
        setState(() {
          navigations.forEach((sel) => sel.selected = false);
          item.selected = true;
        });
      }))));

//    _navigationItem.add(Column(children: <Widget>[],mainAxisSize: MainAxisSize.min,));
//    return BottomAppBar(
//      color: Colors.red,
//      child: Container(width: size.width,height: global.pxl50,)
//      Row(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        crossAxisAlignment: CrossAxisAlignment.end,
//        children: _navigationItem,
//      ),
//    );

    return Container(
      height: size.longestSide * .1,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, -2),
            color: MColor.lightGreyB6.withOpacity(0.5))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _navigationItem,
      ),
    );
  }
}
