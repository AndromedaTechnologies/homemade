import 'package:flutter/material.dart';
import 'package:homemade/model/myprofile.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/globalClass.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/stream/dish/event.dart';
import 'package:homemade/stream/dish/stream.dart';
import 'package:homemade/stream/myprofile/event.dart';
import 'package:homemade/stream/myprofile/state.dart';
import 'package:homemade/stream/myprofile/stream.dart';
import 'package:homemade/widget/AppBarCustom.dart';
import 'package:homemade/widget/loading.dart';
import 'package:provider/provider.dart';

import 'myprofile/about.dart';
import 'myprofile/mydishes.dart';
import 'myprofile/reviews.dart';

class MyProfileView extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileView>
    with SingleTickerProviderStateMixin{

  MyProfileStream stream;

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    stream = MyProfileStream(Global.globalScaffoldKey);
    stream.dispatch(FetchData());

    super.initState();
  }

//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//    print("Did change dependency");
//    stream.dispatch(FetchData());
////    _getUserDat_PendingFeedback_CompletedTreatment();
//  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Global.globalScaffoldKey,
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
                Tab(
                  text: "About",
                ),
                Tab(
                  text: "My Dishes",
                ),
                Tab(
                  text: "Review",
                ),
              ]),
//    titleSpacing: 1.2,
        ),
        body: _tabBarViewController());
  }

  Widget _tabBarViewController() {
    return StreamProvider<MyProfileState>.value(
      value: stream.myProfileStream,
      child: TabBarViewController(_tabController),
    );
  }
}

class TabBarViewController extends StatelessWidget {
  final TabController _tabController;

  TabBarViewController(this._tabController);

  @override
  Widget build(BuildContext context) {
//    return Center(child: Loading(),);

    MyProfileState profileState = Provider.of<MyProfileState>(context);

    print("Statee $profileState");
    if (profileState is ErrorState) {
      return Center(child: Text("Error while Processing Request"));
    }

    if (profileState is DataLoadingState) {
      return TabBarView(controller: _tabController, children: [
        Center(
          child: Loading(),
        ),
        MyDishesView(),
        Center(
          child: Loading(),
        )
      ]);
    }

    if (profileState is DataFetchedState) {
      if (!profileState.hasData) {
        return Center(child: Text("No Data Found"));
      }
    }

    return TabBarView(
        controller: _tabController,
        children: [AboutView(), MyDishesView(), ReviewsView()]);
  }
}
