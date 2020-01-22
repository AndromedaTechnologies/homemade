import 'package:flutter/material.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/UserModel.dart';
import 'package:homemade/model/chefDetailModel.dart';
import 'package:homemade/model/loginModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/stream/user/UserProvider.dart';
import 'package:homemade/stream/user/UserProviderInstance.dart';
import 'package:homemade/view/auth/login.dart';
import 'package:homemade/view/chef//register_update.dart';
import 'package:homemade/view/chef/add_update_dish.dart';
import 'package:homemade/view/chef/myprofile.dart';
import 'package:homemade/widget/ImageInitials.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:page_transition/page_transition.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {


  List<ProfileData> profileDataList = [
    ProfileData(text: "Chef Settings", image: chefImage,),
    ProfileData(text: "Add Dish", image: dinnerImage,),
    ProfileData(text: "My Profile", image: manUserImage,),
    ProfileData(text: "My Orders", image: shoppingImage,),
    ProfileData(text: "Settings", image: settingsImage,),
    ProfileData(text: "Sign Out", image: logoutImage),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                        firstName: UserInstance.instance.user.firstName,
                        lastName: UserInstance.instance.user.lastName,
                        imageURL: UserInstance.instance.user.image,
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
              (UserInstance?.instance?.user?.firstName ?? "") + " " +
                  (UserInstance?.instance?.user?.lastName ?? ""),
//              UserInstance.instance.user.firstName + " " + (UserInstance?.instance?.user?.lastName??""),
              style: TextStyles.textStyleHardBold(fontSize: 26),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _listOfAction(),
          SizedBox(
            height: 15,
          ),

          _becomeChef(),

        ],
      ),
    );
  }

  _becomeChef() {
    return UserInstance.instance.user.role == "1" ? Column(children: <Widget>[
      SizedBox(
        height: 15,
      ),

      RoundedBorderButton(
        boldText: false,
        width: MySize.of(context).fitWidth(66),
        text: "Become A Chef",
        borderRadius: 5,
        height: 50,
        onTap: () {
          Navigator.of(context).push(
              PageTransition(child: ChefRegisterUpdateView(),
                  type: PageTransitionType.downToUp));
        },
      ),

      SizedBox(
        height: 15,
      ),
    ],) : Container();
  }

  _listOfAction() {
    List<ProfileData> data = UserInstance.instance.user.role == "1"
        ? profileDataList.getRange(3, profileDataList.length).toList()
        : profileDataList;

    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        itemCount: data.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return _row(data[index]
            ..onTap = () {
              _pageNavigationSelection(index);
            });
        });
  }

  Widget _row(ProfileData profileData) {
    return InkWell(
      onTap: profileData.onTap,
      child: Container(
        height: 55,
        color: (profileDataList.indexOf(profileData) +
            (UserInstance.instance.user.role == "1" ? 0 : 1)) % 2 == 0 ? Colors
            .white : MColor.lightGreyEC,
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
                    profileData?.text ?? "",
                    style: TextStyles.textStyleNormalSemiBold(),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _pageNavigationSelection(int index) {
    index = index + (UserInstance.instance.user.role == "1" ? 3 : 0);
    print(index);
    Widget navigation;
    switch (index) {
      case 0:
        navigation = ChefRegisterUpdateView(isUpdate: true,);
        break;
      case 1:
        navigation = DishAddUpdateView();
        break;
      case 2:
        navigation = MyProfileView();

        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        LoginModel.signOut();

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
            PageTransition(
                child: LoginView(), type: PageTransitionType.downToUp));

        break;
    }

    if (navigation != null)
      Navigator.of(context)
          .push(
          PageTransition(child: navigation, type: PageTransitionType.downToUp))
          .then((response) {
        if (response != null)
          CustomSnackBar.SnackBar_3Success(
              UserInstance.instance.scaffoldKey, leadingIcon: Icons.check,
              title: response == "success" ? index == 1
                  ? "Dish Added Successfully"
                  : "" :response);
      });
  }
}

class ProfileData {
  String text;
  String image;
  Function onTap;

  ProfileData({this.text, this.image, this.onTap});
}
