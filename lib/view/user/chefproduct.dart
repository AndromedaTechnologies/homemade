import 'package:flutter/material.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/DishItem.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ChefProductView extends StatefulWidget {
  @override
  _ChefProductViewState createState() => _ChefProductViewState();
}

class _ChefProductViewState extends State<ChefProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            foodImage,
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MColor.application.withOpacity(0.65),
                  MColor.application,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MySize.of(context).fitHeight(20),
                ),
                Center(
                  child: Text(
                    "Chef Name",
                    style: TextStyles.textStyleBoldWhite(
                        fontSize: 28, spacing: 1.2),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
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
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: ScrollPhysics(),
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => DishItem(
                                dish: DishModel(id: index.toString(),name: "Dummy"),
                              ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            left: 10,
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
