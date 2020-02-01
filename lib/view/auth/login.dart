import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homemade/error/debugerror.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/Facebook_User.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/stringapi.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/server/GeneralAPI.dart';
import 'package:homemade/server/facebook.dart';
import 'package:homemade/view/auth/register.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';
import 'package:homemade/widget/errorMessage.dart';
import 'package:homemade/widget/loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:dio/dio.dart' as dio;

import '../wrapper.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController emailaddressController;
  TextEditingController passwordController;

  FocusNode emailaddressFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool serverError = false;
  bool submit = false;

  String errorMessage = "";
  FacebookAuth facebookAuth = FacebookAuth();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailaddressController = TextEditingController();
    passwordController = TextEditingController();

    emailaddressFocus.addListener(() {
      print("emailaddressFocus");
      setState(() {});
    });
    passwordFocus.addListener(() {
      print("newpasswordFocus");

      setState(() {});
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColor.white,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MySize.of(context).fitHeight(15),
                ),
                FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    width: MySize.getLongestSide(100),
                    height: MySize.getLongestSide(100),
                    fit: BoxFit.contain,
                    image: AssetImage(logoImage)),
                Text(
                  "Welcome to FOOD",
                  style: TextStyles.textStyleBold(fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MySize.of(context).fitWidth(40), minWidth: 0),
                  child: Text("helping you to find the best homemade food",
                      textAlign: TextAlign.center,
                      style: TextStyles.textStyleNormalGrey()),
                ),
                SizedBox(
                  height: 35,
                ),
                TextFieldWithImage(
                  onValidate: (val) {
                    if (_emailCondition(val)) {
                      print(_emailCondition(val));
                      return "Invalid Email";
                    }
                    return null;
                  },
                  onChange: (val) {},
                  errorMessage: "Invalid Email",
                  focusNode: emailaddressFocus,
                  controller: emailaddressController,
                  onSubmit: (val) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                    setState(() {});
                  },
                  width: MySize.of(context).fitWidth(80),
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                  hint: "example@example.com",
                  label: "Email",
                  imagePath: logoImage,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWithImage(
                  onValidate: (val) {
                    if (_passwordCondition(val)) {
                      print(_passwordCondition(val));
                      return "Invalid Password";
                    }
                    return null;
                  },
                  errorMessage: "Invalid Password",
                  controller: passwordController,
                  focusNode: passwordFocus,
                  onSubmit: (val) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {});
                  },
                  width: MySize.of(context).fitWidth(80),
                  obscureText: true,
                  textInputType: TextInputType.emailAddress,
                  action: TextInputAction.done,
                  hint: "",
                  label: "Password",
                  imagePath: logoImage,
                ),
                SizedBox(
                  height: MySize.of(context).fitHeight(5),
                ),
                submit
                    ? Center(
                        child: Loading(),
                      )
                    : RoundedBorderButton(
                        text: "Log in",
//                width: M,
                        onTap: _validateForm,
                      ),SizedBox(
                  height: MySize.of(context).fitHeight(5),
                ),
                submit
                    ? Center(
                        child: Loading(),
                      )
                    : RoundedBorderButton(
                        text: "Log in with Facebook",height: 40,
//                width: M,
                        onTap: _facebookLogin,
                      ),
                SizedBox(
                  height: 10,
                ),
                errorMessage != "" ? ErrorMessage(errorMessage) : Container(),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(PageTransition(
                        child: RegisterView(), type: PageTransitionType.downToUp));
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Do not have an account?",
                          style: TextStyles.textStyleNormal(),
                          children: [
                        TextSpan(
                            text: " Register".toUpperCase(),
                            style: TextStyles.textStyleBold(fontSize: 16)),
                      ])),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _emailCondition(String val) {
    return val.isEmpty || serverError;
  }

  _passwordCondition(String val) {
    return val.isEmpty || serverError;
  }

  ///Functions
  _validateForm() {
    setState(() {
      serverError = false;
      errorMessage="";
    });
    if (_form.currentState.validate()) {
      _LoginUser();
    }
  }

  _facebookLogin(){
    facebookAuth.signInWithFaceBook(
        scaffoldKey: _scaffoldKey,
        loginSuccessful: (Facebook facebookuser) {
          Base64Codec BASE64 = Base64Codec();
          Latin1Codec LATIN1 = Latin1Codec();

          var bytesInLatin1 =
          LATIN1.encode(facebookuser.id);

          String password =
          BASE64.encode(bytesInLatin1);

          String email = facebookuser.email
              .replaceAll('\u0040', '@')
              .replaceAll('\\u0040', '@');

          CustomSnackBar.SnackBar_3Success(_scaffoldKey,title: "Facebook Success, Coming Soon",leadingIcon: Icons.warning);
        });
  }

  ///Server Call
  _LoginUser() async {
    print("HERE");
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      submit = true;
    });

    try {


      dio.FormData data = dio.FormData.fromMap({
        "email": emailaddressController.text,
        "password": passwordController.text
      });

      dio.Response response = await API(_scaffoldKey).postWithoutTokenAndStoreUserData(
          url: LOGIN_URL, body: data,storeUserData: true);

      setState(() {
        submit = false;
      });

      if (response != null) {
        Navigator.of(context).popUntil((route)=>route.isFirst);
        Navigator.of(context).pushReplacement(PageTransition(
            child: WrapperStream(), type: PageTransitionType.downToUp));
      }
    } catch (e) {
      print(e);
    }
  }
}
