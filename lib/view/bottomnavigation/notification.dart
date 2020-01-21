import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/ImageInitials.dart';
import 'package:homemade/widget/SearchTextField.dart';
import 'package:transparent_image/transparent_image.dart';

class NotificationView extends StatelessWidget {
  TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top + 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(4, 2))
                  ]),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      houseImage,
                      width: 30,
                      height: 30,
                      color: MColor.application.withOpacity(0.7),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SearchTextField(
                      controller: _searchController,
                      hint: "Search",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Check Map",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                              Image.asset(
                                mapImage,
                                width: 30,
                                height: 30,
                                color: MColor.application.withOpacity(0.7),
                              ),
                              Text(
                                "Islamabad",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Filter",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                              Image.asset(
                                filterImage,
                                width: 30,
                                height: 30,
                                color: MColor.application.withOpacity(0.7),
                              ),
                              Text(
                                "Default",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Latest Dishes",
              style: TextStyles.textStyleHardBold(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 260,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Most Popular",
              style: TextStyles.textStyleHardBold(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 260,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Top Chefs",
              style: TextStyles.textStyleHardBold(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 230,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                ],
              ),
            ),

            SizedBox(height: 30,)

          ],
        ),
      ),
    );
  }

  Widget productUI({bool topChefs = false}) {
    return Container(
      width: 180,
      height: topChefs ? 230 : 260,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          border: Border.all(color: MColor.lightGreyB6), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(foodImage),
            fit: BoxFit.cover,
            height: 130,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ImageInitials(
                      firstName: "Jane",
                      lastName: "Doe",
                      height: 50,
                      width: 50,
                      fontSize: 20,
                      imageURL: null,
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
                            "Jane" + " " + "Doe",
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
                                starImage,
                                height: 16,
                                width: 16,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "0.0",
                                style:
                                    TextStyles.textStyleStarBold(fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(0)",
                                style:
                                    TextStyles.textStyleBoldGrey(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                topChefs
                    ? Text.rich(TextSpan(
                        text: "City: ", style: TextStyles.textStyleNormal(),children: [
                          TextSpan(text: "Islamabad",style: TextStyles.textStyleBold().copyWith(color: MColor.application.withOpacity(0.8)))
                ]))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Paratha Roll",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textStyleNormal(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    starImage,
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0.0",
                                    style: TextStyles.textStyleStarBold(
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "(0)",
                                    style: TextStyles.textStyleBoldGrey(
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Price ",
                                    style: TextStyles.textStyleNormal(
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "\$ 30",
                                    style: TextStyles.textStyleHardBold(
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
