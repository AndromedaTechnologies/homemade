import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'chefproduct.dart';

showChefBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => ChefBottomSheet(),
    backgroundColor: Colors.transparent,
  ).then((response) {});
}

class ChefBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Chef Name",
                  style: TextStyles.textStyleHardBold(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300], spreadRadius: 0, blurRadius: 8)
                  ]),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: MColor.application,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                locationImage,
                                width: 30,
                                height: 30,
                                color: Colors.white,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SmoothStarRating(
                              color: MColor.starYellow,
                              size: 30,
                              spacing: 1,
                              allowHalfRating: true,
                              borderColor: MColor.starYellow,
                              rating: 4.5,
                              starCount: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Location Address",
                              style: TextStyles.textStyleNormal(fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Contact Number",
                              style: TextStyles.textStyleNormal(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedBorderButton(
                  text: "Take a look".toUpperCase(),
                  width: double.maxFinite,
                  borderRadius: 5,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(PageTransition(
                        child: ChefProductView(),
                        type: PageTransitionType.downToUp));
                  },
                  boldText: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
