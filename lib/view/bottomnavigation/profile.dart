import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/view/myaccount///register.dart';
import 'package:homemade/view/myaccount/myprofile.dart';
import 'package:homemade/widget/ImageInitials.dart';
import 'package:page_transition/page_transition.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<ProfileData> profileDataList = [
    ProfileData(text: "Chef Settings", image: chefImage, isWhite: false),
    ProfileData(text: "My Dishes", image: dinnerImage, isWhite: true),
    ProfileData(text: "My Profile", image: manUserImage, isWhite: false),
    ProfileData(text: "My Orders", image: shoppingImage, isWhite: true),
    ProfileData(text: "Settings", image: settingsImage, isWhite: false),
    ProfileData(text: "Sign Out", image: logoutImage, isWhite: true),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            child: Stack(
              overflow: Overflow.visible,
//        fit: StackFit.passthrough,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 90,
                  color: MColor.lightGreyEC,
                ),
                Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ImageInitials(
                        firstName: "Zee",
                        lastName: "Zee",
                        height: 120,
                        width: 120,
                        fontSize: 40,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "Zee Zee",
              style: TextStyles.textStyleHardBold(fontSize: 26),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: profileDataList.length,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return _row(profileDataList[index]
                  ..onTap = () {
                    _pageNavigationSelection(index);
                  });
              })
        ],
      ),
    );
  }

  Widget _row(ProfileData profileData) {
    return InkWell(
      onTap: profileData.onTap,
      child: Container(
        height: 55,
        color: profileData.isWhite ? Colors.white : MColor.lightGreyEC,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.asset(
                  profileData.image,
                  color: MColor.application,
                  fit: BoxFit.contain,
                  width: 30,
                  height: 30,
                )
//              FadeInImage(
//                  placeholder: MemoryImage(kTransparentImage),
//                  width: 35,
//                  height: 35,
//                  fit: BoxFit.contain,
//                  image: AssetImage(profileData.image)),
                ),
            Expanded(
              flex: 7,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    profileData.text,
                    style: TextStyles.textStyleNormalSemiBold(),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _pageNavigationSelection(int index) {
    Widget navigation;
    switch (index) {
      case 0:
        navigation = ChefRegisterView();
        break;
      case 1:
        break;
      case 2:
        navigation = MyProfileView();

        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
    }

    if (navigation != null)
      Navigator.of(context).push(
          PageTransition(child: navigation, type: PageTransitionType.downToUp));
  }
}

class ProfileData {
  String text;
  String image;
  bool isWhite;
  Function onTap;

  ProfileData({this.text, this.image, this.isWhite, this.onTap});
}
