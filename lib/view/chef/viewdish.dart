import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homemade/model/UserModel.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/model/myprofile.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/stream/myprofile/state.dart';
import 'package:homemade/widget/ImageInitials.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'add_update_dish.dart';

class DishDetailView extends StatefulWidget {
  final DishModel dishModel;
  final UserModel userModel;

  const DishDetailView({Key key, this.dishModel, this.userModel})
      : super(key: key);

  @override
  _DishDetailViewState createState() => _DishDetailViewState();
}

class _DishDetailViewState extends State<DishDetailView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 270,
              width: double.maxFinite,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: "mydish_hero" + widget.dishModel.id,
                    child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: 270,
                        image: widget.dishModel.dishimages.length > 0
                            ? NetworkImage(widget.dishModel.dishimages[0].image)
                            : AssetImage(notAvailableImage)),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top ,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Platform.isIOS? Icons.arrow_back_ios : Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _topHeadingInformation(),
            SizedBox(
              height: 10,
            ),
            Container(
              color: MColor.lightGreyB6,
              height: 1.0,
            ),
            SizedBox(
              height: 20,
            ),
            _productDetail(),
            SizedBox(
              height: 30,
            ),
            Container(
              color: MColor.lightGreyB6,
              height: 1.0,
            ),
            _reviews(),
            Container(
              color: MColor.lightGreyB6,
              height: 1.0,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _topHeadingInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.dishModel.name,
                  style: TextStyles.textStyleHardBold()
                      .copyWith(color: MColor.applicationDark),
                ),
              ),
              RoundedBorderButton(
                boldText: false,
                width: MySize.of(context).fitWidth(26),
                text: "Edit",
                borderRadius: 5,
                height: 35,
                onTap: _updateDish,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              ImageInitials(
                firstName: widget?.userModel?.firstName ?? "",
                lastName: widget?.userModel?.lastName ?? "",
                height: 50,
                width: 50,
                fontSize: 20,
                imageURL: widget?.userModel?.image ?? null,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (widget?.userModel?.firstName ?? "") +
                          " " +
                          (widget?.userModel?.lastName ?? ""),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textStyleHardBold(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ukImage,
                          width: 30,
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "United Kingdom",
                          style: TextStyles.textStyleNormal(fontSize: 14),
                        ),
                        Spacer(),
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
                              style: TextStyles.textStyleStarBold(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _map(),
          SizedBox(
            height: 5,
          ),
          _detail("Cuisine Type: ", widget.dishModel.cuisineType),
          _detail("Serving Size: ", widget.dishModel.servingSize),
          _detail("Dietary Information: ", widget.dishModel.dietaryInformation),
          _detail("Course Type: ", widget.dishModel.courseType),
          _detail(
              "Ingredients: ", _stringFromList(widget.dishModel.ingredients)),
          _detail(
              "Serving Time: ", _stringFromList(widget.dishModel.servingtime)),
          _detail("Price: ", widget.dishModel.price),
          _detail("Description: ", widget.dishModel.description),
        ],
      ),
    );
  }

  Widget _map() {
    return Row(
      children: <Widget>[
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: MColor.darkGrey, width: 1),
              image: DecorationImage(
                  image: AssetImage(notAvailableImage), fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 8.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "7 Miles",
              style: TextStyles.textStyleNormalDarkGreySemiBold(fontSize: 13),
            ),
            Text(
              "Islamabad",
              style: TextStyles.textStyleNormalDarkGreySemiBold(fontSize: 13),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "View Map",
              style: TextStyles.textStyleNormalSemiBold(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }

  Widget _detail(String heading, String detail) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text.rich(TextSpan(
          text: heading,
          style: TextStyles.textStyleHardBold(fontSize: 16)
              .copyWith(color: MColor.applicationDark),
          children: [
            TextSpan(text: detail, style: TextStyles.textStyleNormal())
          ])),
    );
  }

  Widget _reviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text(
                "180 Reviews",
                style: TextStyles.textStyleBold(fontSize: 16),
              ),
              SizedBox(
                width: 15,
              ),
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
                    style: TextStyles.textStyleStarBold(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  String _stringFromList(List<String> _list) {
    String returnS = "";
    for (var item in _list) {
      print(item);
      returnS += item + ", ";
    }

    return _list.length > 0 ? returnS.substring(0, returnS.length - 2) : "";
  }

  _updateDish(){
    Navigator.of(context).push(PageTransition(
        child: DishAddUpdateView(
          dishModel: widget.dishModel,
          isUpdate: true,
        ),
        type: PageTransitionType.downToUp));

  }
}
