import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/AppBarCustom.dart';

import 'myprofile/about.dart';
import 'myprofile/mydishes.dart';
import 'myprofile/reviews.dart';

class MyProfileView extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
//      _tabController.
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MColor.application,
        title: Text(
          "My Profile",
          style: TextStyles.textStyleBoldWhite(spacing: 7, fontSize: 20),
        ),
        centerTitle: true,
        bottom: TabBar(
            labelStyle: TextStyles.textStyleNormalWhite(),
            controller: _tabController,
indicatorColor: Colors.white,
//            indicator: BoxDecoration(
//
//            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,

//            indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
            tabs: [
              Tab(text: "About",),
              Tab(text: "My Dishes",),
              Tab(text: "Review",),
            ]),
//    titleSpacing: 1.2,
      ),
      body:  _tabBarViewController()

    );
  }

  Widget _tabBarViewController(){
    return TabBarView(controller: _tabController,children: [
      AboutView(),
      MyDishesView(),
      ReviewsView()
    ]);
  }

}
