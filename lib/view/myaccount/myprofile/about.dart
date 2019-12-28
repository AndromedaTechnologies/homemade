import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/ImageInitials.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _userInfo(),
          Container(
            color: MColor.lightGreyB6,
            height: 0.6,
          ),
          SizedBox(
            height: 25,
          ),
          _description(),
          SizedBox(
            height: 25,
          ),
          Container(
            color: MColor.lightGreyB6,
            height: 0.6,
          ),
          SizedBox(
            height: 25,
          ),
          _awards(),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _heading(String title) {
    return Text(
      title,
      style: TextStyles.textStyleHardBold(),
    );
  }

  Widget _userInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageInitials(
                firstName: "Zee",
                lastName: "Zee",
                height: 75,
                width: 75,
                fontSize: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Zee Zee",
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
                          "5.0",
                          style: TextStyles.textStyleStarBold(fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(2)",
                          style: TextStyles.textStyleBoldGrey(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _heading("User Information:"),
          SizedBox(
            height: 20,
          ),
          _userLocationInfo(
              imageURL: locationImage,
              title: "Pickup Location",
              heading: "212B Location to pick"),
          SizedBox(
            height: 20,
          ),
          _userLocationInfo(
              imageURL: userBottomImage,
              title: "Member Since",
              heading: "212B Members since"),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _userLocationInfo({String imageURL, String title, String heading}) {
    return Row(
      children: <Widget>[
        Image.asset(
          imageURL,
          width: 28,
          height: 28,
          color: MColor.lightGreyB6,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyles.textStyleHardBoldGrey(fontSize: 14),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              heading,
              style: TextStyles.textStyleHardBold(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _heading("Description"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Monotype’s fonts and technologies bring "
            "the world’s words to the page and screen. "
            "Included in the catalogue are classic designs "
            "from ITC, FontFont and Linotype.",
            style: TextStyles.textStyleNormalDarkGrey(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _awards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _heading("Awards:"),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 8,
            children: _awardsList(),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "See 6 more",
            style: TextStyles.textStyleHardBold(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  List<Widget> _awardsList() {
    return [1, 2, 3, 4, 5, 6, 7, 8].map((res) => _awardChip()).toList();
  }

  Widget _awardChip() {
    return InputChip(
      label: Text(
        "AwardI Item",
        style: TextStyles.textStyleNormalDarkGreySemiBold(fontSize: 14)
            .apply(color: Colors.black),
      ),
      backgroundColor: MColor.lightGreyB6,
      isEnabled: true,
      disabledColor: MColor.lightGreyB6,
      selectedColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    );
  }
}
