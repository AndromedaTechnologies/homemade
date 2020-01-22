import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/UserModel.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/globalClass.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/stream/myprofile/state.dart';
import 'package:homemade/view/chef/viewdish.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class MyDishesView extends StatefulWidget {
  @override
  _MyDishesViewState createState() => _MyDishesViewState();
}

class _MyDishesViewState extends State<MyDishesView> {
  @override
  Widget build(BuildContext context) {
    MyProfileState profileState = Provider.of<MyProfileState>(context);

    if (profileState is DataLoadingState) {
      return shimmerWidget();
    }

    if (profileState is DataFetchedState) {
      return ListView.builder(
          itemCount:
              profileState?.myProfileModel?.user?.chef?.dishes?.length ?? 0,
          itemBuilder: (context, index) {
            return dishWidget(
                profileState.myProfileModel.user.chef.dishes[index],
                profileState.myProfileModel.user);
          });
    }
  }

  Widget dishWidget(DishModel dish, UserModel userModel) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(PageTransition(
                child: DishDetailView(
                  dishModel: dish,
                  userModel: userModel,
                ),
                type: PageTransitionType.downToUp))
            .then((response) {
          print("DishDetailView Response $response");
          if (response != null) {

            CustomSnackBar.SnackBar_3Success(Global.globalScaffoldKey,
                leadingIcon: Icons.check, title: "Dish Updated Successfully");
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: MColor.lightGreyB6),
            boxShadow: [
              BoxShadow(
                  color: MColor.lightGreyB6,
                  offset: Offset(0, 2),
                  blurRadius: 3,
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 160,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: "mydish_hero" + dish.id,
                      child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          fit: BoxFit.cover,
                          height: 160,
                          image: dish.dishimages.length > 0
                              ? NetworkImage(dish.dishimages[0].image)
                              : AssetImage(notAvailableImage)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                starImage,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "5.0",
                                style:
                                    TextStyles.textStyleStarBold(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(2)",
                                style:
                                    TextStyles.textStyleBoldGrey(fontSize: 16),
                              ),
                              Spacer(),
                              Image.asset(
                                heartBorderImage,
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dish.name,
                            style: TextStyles.textStyleNormalDarkGreySemiBold(
                                fontSize: 14),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "\$ ${dish.price}",
                                style:
                                    TextStyles.textStyleHardBold(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerWidget() {
    Color baseColor = Colors.grey[300];
    Color highlightColor = Colors.grey[100];
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: MColor.lightGreyB6),
                boxShadow: [
                  BoxShadow(
                      color: MColor.lightGreyB6,
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      spreadRadius: 0)
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 160,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Image.asset(
                                      starImage,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Text(
                                      "5.0",
                                      style: TextStyles.textStyleStarBold(
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Text(
                                      "(0)",
                                      style: TextStyles.textStyleBoldGrey(
                                          fontSize: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Image.asset(
                                      heartBorderImage,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Text(
                                  "                ",
                                  style: TextStyles
                                      .textStyleNormalDarkGreySemiBold(
                                          fontSize: 14),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Text(
                                      "\$ 000",
                                      style: TextStyles.textStyleHardBold(
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
