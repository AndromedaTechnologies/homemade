import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/ImageInitials.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewsView extends StatefulWidget {
  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _rating(),
//        SizedBox(
//          height: 20,
//        ),
        Container(
          color: MColor.lightGreyB6,
          height: 1.0,
        ),

        _commentsAndStar(),
      ],
    ));
  }

  Widget _rating() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Overall Rating",
                style: TextStyles.textStyleHardBold(fontSize: 22),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Image.asset(
                    starImage,
                    height: 26,
                    width: 26,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "5.0",
                    style: TextStyles.textStyleStarBold(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _ratingRow("Seller communication"),
                SizedBox(
                  height: 15,
                ),
                _ratingRow("Service as described"),
                SizedBox(
                  height: 15,
                ),
                _ratingRow("Would recommend"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _ratingRow(String text) {
    return Row(
      children: <Widget>[
        Text(
          text??"",
          style: TextStyles.textStyleNormalSemiBold(fontSize: 16),
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
    );
  }

  Widget _commentsAndStar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
//      mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                "Sorted by most relevant",
                style: TextStyles.textStyleHardBold(fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              itemCount: 8,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageInitials(
                          width: 55,
                          height: 55,
                          fontSize: 25,
                          firstName: "Zee",
                          lastName: "Zee",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              _commentRatingRow("Zee Zee"),
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
                                    style: TextStyles.textStyleNormal(
                                        fontSize: 14),
                                  ),
                                  Spacer(),
                                  Text(
                                    "6 days ago",
                                    style:
                                        TextStyles.textStyleNormalGreySemiBold(
                                            fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                                "Donec ac est quis quam sodales venenatis. Nulla tincidunt"
                                "molestie elit id scelerisque. Vestibulum interdum enim quis"
                                "magna facilisis euismod. Ut eu dolor urna.",
                                style: TextStyles.textStyleNormalDarkGrey(
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),

          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _commentRatingRow(String text) {
    return Row(
      children: <Widget>[
        Text(
          text??"",
          style: TextStyles.textStyleHardBold(fontSize: 16),
        ),
        Spacer(),
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
              "5.0",
              style: TextStyles.textStyleStarBold(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
