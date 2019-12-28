import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textFieldConditions.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/view/classes/cuisine.dart';
import 'package:homemade/widget/ImageSelect.dart';
import 'package:homemade/widget/OutlineBorderButton.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:homemade/widget/TextFieldClicked.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class ChefRegisterView extends StatefulWidget {
  @override
  _ChefRegisterViewState createState() => _ChefRegisterViewState();
}

class _ChefRegisterViewState extends State<ChefRegisterView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  GlobalKey<FormState> _form2 = GlobalKey<FormState>();
  GlobalKey<FormState> _form3 = GlobalKey<FormState>();
  GlobalKey<FormState> _form4 = GlobalKey<FormState>();

  int currentIndex = 0;
  int totalIndexLength = 4;

  TextEditingController businessNameController;
  TextEditingController businessAddressController;
  TextEditingController businessCityController;
  TextEditingController businessStateController;
  TextEditingController businessPostalCodeController;
  TextEditingController businessPhoneController;
  TextEditingController businessEmailController;
  TextEditingController governmentIDController;
  TextEditingController ibanController;
  TextEditingController bankNameController;

  FocusNode businessNameFocus = FocusNode();
  FocusNode businessAddressFocus = FocusNode();
  FocusNode businessCityFocus = FocusNode();
  FocusNode businessStateFocus = FocusNode();
  FocusNode businessPostalCodeFocus = FocusNode();
  FocusNode businessPhoneFocus = FocusNode();
  FocusNode businessEmailFocus = FocusNode();
  FocusNode governmentIDFocus = FocusNode();
  FocusNode ibanFocus = FocusNode();
  FocusNode bankNameFocus = FocusNode();

  TextEditingController experienceController;
  TextEditingController pickUpLocationController;

  List<String> awardAndCertifications = [];

  File _professionalImage;
  File frontFile;
  File backFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColor.white,
      appBar: AppBar(
        backgroundColor: MColor.white,
        elevation: 0,
        iconTheme: IconThemeData(color: MColor.application),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: MColor.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(color: MColor.lightGreyB6,blurRadius: 3,spreadRadius: 0,offset: Offset(0, 3)),
              ]
            ),
            alignment: Alignment.center,
            child: Text(
              "Chef Registration",
              style: TextStyles.textStyleNormalLightItalic(
                  fontSize: 32, letterSpacing: 1.2),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: MColor.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: MColor.lightGreyB6,
                              offset: Offset(0, 4),
                              blurRadius: 4.0,
                              spreadRadius: 0)
                        ]),
                    child: _stepperCheck()),
                _bottomButtons(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _stepperCheck() {
    switch (currentIndex) {
      case 0:
        return _stepperOne();
        break;
      case 1:
        return _stepperTwo();
        break;
      case 2:
        return _stepperThree();
        break;
      case 3:
        return _stepperFour();
        break;
      default:
        return Container();
    }
  }

  Widget _stepperOne() {
    return Form(
      key: _form1,
      child: Column(
        children: <Widget>[
          _stepperHeading("Business Profile"),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Provide Business Name";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Provide Business Name",
            focusNode: businessNameFocus,
            controller: businessNameController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessAddressFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "Business Name",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Please Provide Business Address";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide Business Address",
            focusNode: businessAddressFocus,
            controller: businessAddressController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessCityFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "Business Address",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                print(Condition.nonEmptyCondition(val));
                return "Please Provide City";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide City",
            focusNode: businessCityFocus,
            controller: businessCityController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessStateFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "City",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                print(Condition.nonEmptyCondition(val));
                return "Please Provide State";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide State",
            focusNode: businessStateFocus,
            controller: businessStateController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessPostalCodeFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "State",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Please Provide Postal Code";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide Postal Code",
            focusNode: businessPostalCodeFocus,
            controller: businessPostalCodeController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessPhoneFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "Postal Code",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Please Provide Phone";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide Phone",
            focusNode: businessPhoneFocus,
            controller: businessPhoneController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessEmailFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "Phone Number",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Please Provide Email";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide Email",
            focusNode: businessEmailFocus,
            controller: businessEmailController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            action: TextInputAction.done,
            hint: "example@example.com",
            label: "Email Address",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _stepperTwo() {
    return Form(
      key: _form2,
      child: Column(
        children: <Widget>[
          _stepperHeading("Professional Profile"),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: MColor.lightGreyB6, width: 1))),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
//                      color:Colors.red,
                    padding: EdgeInsets.only(right: 18, top: 5),
                    width: MySize.of(context).fitWidth(80),
                    child: Wrap(
                        spacing: 4,
                        children: selectedCuisines().length > 0
                            ? selectedCuisines()
                            : [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Select Cuisine".toUpperCase(),
                                    style: TextStyles.textStyleBold(
                                        fontSize: 16, spacing: 4.0),
                                  ),
                                ),
                              ]),
                  ),
                ),
                DropdownButton<dynamic>(
                  value: null,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: MColor.lightGreyB6,
                  ),
                  iconSize: 24,
                  elevation: 0,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (index) {
//                              List<String> split =
//                              techDropDownSelectedValue.split(',');
//                              split.contains(index);
                    setState(() {});
                  },
                  items: cuisinesList
                      .map<DropdownMenuItem<dynamic>>((Cuisine value) {
                    return DropdownMenuItem<dynamic>(
                        value: value.text,
                        child: DropDownItem(
                          cuisine: value,
                          state: this,
                        ));
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Provide Experience";
              }
              return null;
            },
            onChange: (val) {},
            errorMessage: "Provide Experience",
            focusNode: businessNameFocus,
            controller: businessNameController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(businessAddressFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "Experience",
            isSuffixLabel: true,
            suffixLabel: "Month",
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldClicked(
            onTap: _navigateToMap,
            width: MySize.of(context).fitWidth(80),
            controller: pickUpLocationController,
            errorMessage: "Please Provide Location",
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Provide Business Name";
              }
              return null;
            },
            label: "Location",
            isSuffixIcon: true,
            icon: Icons.map,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _alertDialog,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: MColor.lightGreyB6, width: 1))),
              padding: EdgeInsets.only(bottom: 5),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
//                      color:Colors.red,
                      padding: EdgeInsets.only(right: 18, top: 5),
                      width: MySize.of(context).fitWidth(80),
                      child: Wrap(
                          spacing: 4,
                          children: awardsCertifications().length > 0
                              ? awardsCertifications()
                              : [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Awards and Certification".toUpperCase(),
                                      style: TextStyles.textStyleBold(
                                          fontSize: 16, spacing: 4.0),
                                    ),
                                  ),
                                ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

//          _imageSelectionProfessional(),
          ImageSelect(_professionalImage, _callBackFromProfessionalImage),

          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _stepperThree() {
    return Form(
      key: _form3,
      child: Column(
        children: <Widget>[
          _stepperHeading("Verification"),
          SizedBox(
            height: 20,
          ),
          Text(
            "We value the safety of our Foodies, riders "
            "and providers and go an extr "
            "mile to make sure the security of everyone. "
            "Please provide the info to be a verified member.",
            style: TextStyles.textStyleNormalGrey(),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Provide Government ID";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Provide Government ID",
            focusNode: governmentIDFocus,
            controller: governmentIDController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.number,
            action: TextInputAction.done,
            hint: "-",
            label: "Government ID (CNIC)",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _govImage(frontFile, true),
              ),
              Expanded(
                child: _govImage(backFile, false),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _stepperFour() {
    return Form(
      key: _form4,
      child: Column(
        children: <Widget>[
          _stepperHeading("Payment"),
          SizedBox(
            height: 20,
          ),

          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Provide IBAN Number";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Provide IBAN Number",
            focusNode: ibanFocus,
            controller: ibanController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(bankNameFocus);
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.next,
            hint: "-",
            label: "IBAN Number",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWithImage(
            onValidate: (val) {
              if (Condition.nonEmptyCondition(val)) {
                return "Please Provide Bank Name";
              }
              return null;
            },
            removeImageIcon: true,
            onChange: (val) {},
            errorMessage: "Please Provide Bank Name",
            focusNode: bankNameFocus,
            controller: bankNameController,
            onSubmit: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {});
            },
            width: MySize.of(context).fitWidth(80),
            obscureText: false,
            textInputType: TextInputType.text,
            action: TextInputAction.done,
            hint: "-",
            label: "Bank Name",
            imagePath: logoImage,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _govImage(File file, bool front) {
    double widthHeight = 100;
    return InkWell(
      onTap: () {
        _takeImage(front);
      },
      child: file != null
          ? Column(
              children: <Widget>[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.cover,
                        width: widthHeight,
                        height: widthHeight,
                        image: FileImage(file)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                front ? _frontText() : _backText(),
              ],
            )
          : Column(
              children: <Widget>[
                Container(
                  width: widthHeight,
                  height: widthHeight,
                  decoration: BoxDecoration(
                      color: MColor.application,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                front ? _frontText() : _backText(),
              ],
            ),
    );
  }

  Widget _frontText() {
    return Text(
      "Write your CNIC# on paper and "
      "take a picture next to your "
      "face so both your face and "
      "CNIC# is clearly visible.",
      textAlign: TextAlign.center,
      style: TextStyles.textStyleNormalGrey(),
    );
  }

  Widget _backText() {
    return Text(
      "Take a picture of your CNIC so your "
      "picture and CNIC# is clearly visible",
      textAlign: TextAlign.center,
      style: TextStyles.textStyleNormalGrey(),
    );
  }

  Widget _bottomButtons() {
    return Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            currentIndex == 0
                ? Container()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedBorderButton(
                        text: "Back",
                        onTap: _backPressed,
                        height: 50,
                      ),
                    ),
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedBorderButton(
                  text:
                      currentIndex == totalIndexLength - 1 ? "Submit" : "Next",
                  onTap: _nextPressed,
                  height: 50,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _stepperHeading(String heading) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Text(
            heading,
            style: TextStyles.textStyleNormalDarkGreyBold(fontSize: 24),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Step ${currentIndex + 1}/$totalIndexLength",
                style: TextStyles.textStyleNormalGreySemiBold(),
              )),
        ),
      ],
    );
  }

  List<Widget> selectedCuisines() {
    return cuisinesList
        .where((cuisine) => cuisine.isSelected)
        .toList()
        .map((cuisine) {
      return _chipCuisine(cuisine);
    }).toList();
  }

  List<Widget> awardsCertifications() {
    return awardAndCertifications.map((str) => _chip(str)).toList();
  }

  Widget _chipCuisine(Cuisine cuisine) {
    return InputChip(
      label: Text(
        cuisine.text,
        style: TextStyles.textStyleNormalWhite(fontSize: 14),
      ),
      backgroundColor: MColor.application,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      deleteIcon: Icon(
        Icons.clear,
        size: 16,
        color: Colors.white,
      ),
      onDeleted: () {
        cuisine.isSelected = !cuisine.isSelected;
        setState(() {});
      },
    );
  }

  Widget _chip(String text) {
    return InputChip(
      label: Text(
        text,
        style: TextStyles.textStyleNormalWhite(fontSize: 14),
      ),
      backgroundColor: MColor.application,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      deleteIcon: Icon(
        Icons.clear,
        size: 16,
        color: Colors.white,
      ),
      onDeleted: () {
        awardAndCertifications.remove(text);
        setState(() {});
      },
    );
  }

  ///
  ///
  ///Functions
  ///
  ///
  _backPressed() {
    switch (currentIndex) {
      case 0:

        ///this scenario will not execute
        setState(() {
          currentIndex--;
        });
        break;
      case 1:
        setState(() {
          currentIndex--;
        });
        break;
      case 2:
        setState(() {
          currentIndex--;
        });
        break;
      case 3:
        setState(() {
          currentIndex--;
        });
        break;
    }
  }

  _nextPressed() {
    switch (currentIndex) {
      case 0:
//        if (_form1.currentState.validate()) {
        setState(() {
          currentIndex++;
        });
//        }
        break;
      case 1:
//        if (_form2.currentState.validate()) {
        print(_professionalImage == null);
        setState(() {
          currentIndex++;
        });
//        }
        break;
      case 2:
//        if (_form3.currentState.validate()) {
        setState(() {
          currentIndex++;
        });
//        }
        break;
      case 3:
//        if (_form4.currentState.validate()) {
        _submitToServer();
//    }
        break;
    }
  }

  _alertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialogAwardAndCertificate(
              awardAndCertifications, _popDialog);
        });
  }

  _popDialog(List<String> awardsCertificates) {
    awardAndCertifications = awardsCertificates;
    setState(() {});
  }

  _callBackFromProfessionalImage(File file) {
    _professionalImage = file;
  }

  _takeImage(bool condition) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (condition)
        frontFile = image;
      else
        backFile = image;
      setState(() {});
    }
  }

  _navigateToMap() {}

  _submitToServer() {}
}

class DropDownItem extends StatefulWidget {
  Cuisine cuisine;
  State state;

  DropDownItem({this.cuisine, this.state});

  @override
  _DropDownItemState createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        widget.cuisine.isSelected = !widget.cuisine.isSelected;
        setState(() {});

        widget.state.setState(() {});
      },
      child: Row(
        children: <Widget>[
          Container(
              width: MySize.of(context).fitWidth(75),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: widget.cuisine.isSelected
                  ? MColor.lightGreyB6.withOpacity(0.6)
                  : null,
              child: Text(
                widget.cuisine.text,
                style: TextStyles.textStyleNormalDarkGrey(),
              )),
        ],
      ),
    );
  }
}

class AlertDialogAwardAndCertificate extends StatefulWidget {
  final List<String> awardsAndCertificates;
  final Function callBackFunction;

  AlertDialogAwardAndCertificate(
      this.awardsAndCertificates, this.callBackFunction);

  @override
  _AlertDialogAwardAndCertificateState createState() =>
      _AlertDialogAwardAndCertificateState();
}

class _AlertDialogAwardAndCertificateState
    extends State<AlertDialogAwardAndCertificate> {
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.0),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: MColor.lightGreyB6,
                        spreadRadius: 0,
                        blurRadius: 4.0,
                        offset: Offset(0, 3))
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _stepperHeading("Awards and Certifications"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: TextFieldWithImage(
                          controller: controller,
                          label: "Item",
                          removeImageIcon: true,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: FlatButton(
                            onPressed: _addItem,
                            color: MColor.application,
                            child: Text(
                              "Save".toUpperCase(),
                              style: TextStyles.textStyleBoldWhite(
                                  fontSize: 16, spacing: 0.4),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(spacing: 4, children: awardsCertifications()),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                      onPressed: () {
                        widget.callBackFunction(widget.awardsAndCertificates);
                        Navigator.pop(context);
                      },
                      color: MColor.application,
                      child: Text(
                        "Done".toUpperCase(),
                        style: TextStyles.textStyleBoldWhite(
                            fontSize: 16, spacing: 0.4),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> awardsCertifications() {
    return widget.awardsAndCertificates.map((ac) => _chip(ac)).toList();
  }

  Widget _chip(String text) {
    return InputChip(
      label: Text(
        text,
        style: TextStyles.textStyleNormalWhite(fontSize: 14),
      ),
      backgroundColor: MColor.application,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      deleteIcon: Icon(
        Icons.clear,
        size: 16,
        color: Colors.white,
      ),
      onDeleted: () {
        widget.awardsAndCertificates.remove(text);
        setState(() {});
      },
    );
  }

  Widget _stepperHeading(String heading) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Text(
            heading,
            style: TextStyles.textStyleNormalDarkGreyBold(fontSize: 20),
          ),
        ),
      ],
    );
  }

  ///
  ///
  /// Functions
  ///
  _addItem() {
    print("add");
    if (controller.text != "") {
      print("Add ${controller.text}");
      widget.awardsAndCertificates.add(controller.text);
      controller.clear();
      setState(() {});
    }
  }
}
