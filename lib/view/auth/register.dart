import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homemade/error/debugerror.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/stringapi.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/server/GeneralAPI.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';
import 'package:homemade/widget/errorMessage.dart';
import 'package:homemade/widget/loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:dio/dio.dart' as dio;

import '../pageselection.dart';
import '../wrapper.dart';
import 'login.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController phoneNumberController;
  TextEditingController emailAddressController;
  TextEditingController passwordController;

  FocusNode fistNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode emailAddressFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool serverError = false;
  bool submit = false;

  String errorMessage = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();

    emailAddressFocus.addListener(() {
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
                  focusNode: emailAddressFocus,
                  controller: emailAddressController,
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
                    FocusScope.of(context).requestFocus(fistNameFocus);
                    setState(() {});
                  },
                  width: MySize.of(context).fitWidth(80),
                  obscureText: true,
                  textInputType: TextInputType.text,
                  action: TextInputAction.next,
                  hint: "",
                  label: "Password",
                  imagePath: logoImage,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWithImage(
                  onValidate: (val) {
                    if (_firstNameCondition(val)) {
                      print(_firstNameCondition(val));
                      return "Invalid First Name";
                    }
                    return null;
                  },
                  onChange: (val) {},
                  errorMessage: "Invalid Email",
                  focusNode: fistNameFocus,
                  controller: firstNameController,
                  onSubmit: (val) {
                    FocusScope.of(context).requestFocus(lastNameFocus);
                    setState(() {});
                  },
                  width: MySize.of(context).fitWidth(80),
                  obscureText: false,
                  textInputType: TextInputType.text,
                  action: TextInputAction.next,
                  hint: "-",
                  label: "First name",
                  imagePath: logoImage,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWithImage(
                  onValidate: (val) {
                    if (_lastNameCondition(val)) {
                      print(_lastNameCondition(val));
                      return "Invalid Last Name";
                    }
                    return null;
                  },
                  onChange: (val) {},
                  errorMessage: "Invalid Last Name",
                  focusNode: lastNameFocus,
                  controller: lastNameController,
                  onSubmit: (val) {
                    FocusScope.of(context).requestFocus(phoneNumberFocus);
                    setState(() {});
                  },
                  width: MySize.of(context).fitWidth(80),
                  obscureText: false,
                  textInputType: TextInputType.text,
                  action: TextInputAction.next,
                  hint: "-",
                  label: "Last Name",
                  imagePath: logoImage,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWithImage(
                  onValidate: (val) {
                    if (_phoneNumberCondition(val)) {
                      print(_phoneNumberCondition(val));
                      return "Invalid Phone Number";
                    }
                    return null;
                  },
                  onChange: (val) {},
                  errorMessage: "Invalid Phone Number",
                  focusNode: phoneNumberFocus,
                  controller: phoneNumberController,
                  onSubmit: (val) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {});
                  },
                  width: MySize.of(context).fitWidth(80),
                  obscureText: false,
                  textInputType: TextInputType.number,
                  action: TextInputAction.next,
                  hint: "-",
                  label: "Phone Number",
                  imagePath: logoImage,
                ),
                SizedBox(
                  height: MySize.of(context).fitHeight(6),
                ),
                errorMessage != "" ? ErrorMessage(errorMessage) : Container(),

                SizedBox(
                  height: MySize.of(context).fitHeight(6),
                ),

                submit
                    ? Center(
                  child: Loading(),
                )
                    : RoundedBorderButton(
                  text: "Register",
//                width: M,
                  onTap: _validateForm,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(PageTransition(
                        child: LoginView(), type: PageTransitionType.downToUp));
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Do you have an account?",
                          style: TextStyles.textStyleNormal(),
                          children: [
                            TextSpan(
                                text: " Login".toUpperCase(),
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

  _firstNameCondition(String val) {
    return val.isEmpty || serverError;
  }

  _lastNameCondition(String val) {
    return val.isEmpty || serverError;
  }

  _phoneNumberCondition(String val) {
    return val.isEmpty || serverError;
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
      _registerUser();
    }
  }
  ///Server Call
  _registerUser() async {
    print("HERE");
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      submit = true;
    });

    try {


      dio.FormData data = dio.FormData.fromMap({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phone_number": phoneNumberController.text,
        "email": emailAddressController.text,
        "password": passwordController.text
      });

      dio.Response response = await API(_scaffoldKey).postWithoutTokenAndStoreUserData(
          url: REGISTER_URL, body: data,storeUserData: true);


      setState(() {
        submit = false;
      });

      if (response != null) {
        Navigator.of(context).popUntil((route)=>route.isFirst);
        Navigator.of(context).pushReplacement(PageTransition(
            child: WrapperStream(), type: PageTransitionType.downToUp));


        return;
      }
    } catch (e) {
      print(e);
    }
  }
}
