import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/chefDetailModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/stringapi.dart';
import 'package:homemade/res/textFieldConditions.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/server/GeneralAPI.dart';
import 'package:homemade/stream/UserProvider.dart';
import 'package:homemade/stream/UserProviderInstance.dart';
import 'package:homemade/stream/notifier.dart';
import 'package:homemade/dropdownClass/cuisine.dart';
import 'package:homemade/widget/AppBarCustom.dart';
import 'package:homemade/widget/ImageSelect.dart';
import 'package:homemade/widget/MultSelectDropDownItem.dart';
import 'package:homemade/widget/MultiSelectDropDown.dart';
import 'package:homemade/widget/OutlineBorderButton.dart';
import 'package:homemade/widget/PopupMultiInputDialog.dart';
import 'package:homemade/widget/PopupTextField.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:homemade/widget/TextFieldClicked.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';
import 'package:homemade/widget/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:path/path.dart' as path;

class ChefRegisterUpdateView extends StatefulWidget {
  final bool isUpdate;

  ChefRegisterUpdateView({this.isUpdate = false});

  @override
  _ChefRegisterUpdateViewState createState() => _ChefRegisterUpdateViewState();
}

class _ChefRegisterUpdateViewState extends State<ChefRegisterUpdateView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  ChefDetailModel chefDetailModel;

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
  TextEditingController governmentIDCNICController;
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

  FocusNode experienceFocus = FocusNode();

  TextEditingController experienceController;
  TextEditingController pickUpLocationController;

  List<String> awardAndCertifications = [];

  File _professionalImage;
  File frontFileImage;
  File backFileImage;

  bool submitDataLoading = false;
  bool gettingDataLoading = false;
  bool showEditButton = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    businessNameController = TextEditingController();
    businessAddressController = TextEditingController();
    businessCityController = TextEditingController();
    businessStateController = TextEditingController();
    businessPostalCodeController = TextEditingController();
    businessPhoneController = TextEditingController();
    businessEmailController = TextEditingController();
    governmentIDCNICController = TextEditingController();
    ibanController = TextEditingController();
    bankNameController = TextEditingController();
    experienceController = TextEditingController();
    pickUpLocationController = TextEditingController();

    cuisinesList.forEach((cui){cui.selected=false;});

    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
//      _tabController.
    });

    if (widget.isUpdate) gettingChefData();
  }

  gettingChefData() async {
    try {
      setState(() {
        gettingDataLoading = true;
      });
      Response responseGet = await API(_scaffoldKey).get(url: CHEF_URL);

      setState(() {
        gettingDataLoading = false;
      });

      if (responseGet != null) {
        print("Respons eget");
        chefDetailModel = ChefDetailModel.fromJson(responseGet.data);

        businessNameController.text = chefDetailModel.chef.businessName;
        businessAddressController.text = chefDetailModel.chef.businessAddress;
        businessCityController.text = chefDetailModel.chef.city;
        businessStateController.text = chefDetailModel.chef.state;
        businessPostalCodeController.text = chefDetailModel.chef.postalCode;
        businessPhoneController.text = chefDetailModel.chef.businessPhone;
        businessEmailController.text = chefDetailModel.chef.businessEmail;
        governmentIDCNICController.text = chefDetailModel.chef.cnic;
        ibanController.text = chefDetailModel.chef.iban;
        bankNameController.text = chefDetailModel.chef.bankName;
        experienceController.text = chefDetailModel.chef.experience;
        pickUpLocationController.text = chefDetailModel.chef.pickupLocation;
        awardAndCertifications.addAll(
            chefDetailModel.awards.map((award) => award.award).toList());
//        cuisinesList.addAll(chefDetailModel.cuisines.map((cuisine)=>Cuisine()).toList());

        cuisinesList.forEach((cuisine) {
          cuisine.selected = chefDetailModel.cuisines
                  .where((cui) =>
                      cui.cuisine.toLowerCase() == cuisine.text.toLowerCase())
                  .toList()
                  .length >
              0;
        });

        setState(() {});
      }
    } catch (e) {
      print("Getting Chef Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: MColor.white,
        appBar: widget.isUpdate ? _updateAppBar() : _registerAppBar(),
        body: widget.isUpdate ? _updateUI() : _registerUI());
  }

  _updateAppBar() {
    return AppBar(
      backgroundColor: MColor.application,
      title: Text(
        "My Profile",
        style: TextStyles.textStyleBoldWhite(spacing: 7, fontSize: 20),
      ),
      centerTitle: true,
      bottom: TabBar(
          labelStyle: TextStyles.textStyleNormalWhite(fontSize: 14),
          controller: _tabController,
          indicatorColor: Colors.white,
//            indicator: BoxDecoration(
//
//            ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 5,

//            indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
          tabs: [
            Tab(
              text: "Business Profile",
            ),
            Tab(
              text: "Professional Profile",
            ),
            Tab(
              text: "Payment",
            ),
          ]),
//    titleSpacing: 1.2,
    );
  }

  _registerAppBar() {
    return AppBar(
      backgroundColor: MColor.white,
      elevation: 0,
      iconTheme: IconThemeData(color: MColor.application),
    );
  }

  Widget _updateUI() {
    return gettingDataLoading || chefDetailModel == null
        ? Center(
            child: Loading(),
          )
        : Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  submitDataLoading
                      ? Center(
                          child: Loading(),
                        )
                      : RoundedBorderButton(
                          boldText: false,
                          width: MySize.of(context).fitWidth(26),
                          text: showEditButton ? "Edit" : "Save",
                          borderRadius: 5,
                          height: 35,
                          onTap: _editSaveButton,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  SingleChildScrollView(
                    child: _businessProfile(),
                  ),
                  SingleChildScrollView(
                    child: _professionalProfile(),
                  ),
                  SingleChildScrollView(
                    child: _payment(),
                  ),
                ]),
              ),
            ],
          );
  }

  Widget _registerUI() {
    return Column(
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
                BoxShadow(
                    color: MColor.lightGreyB6,
                    blurRadius: 3,
                    spreadRadius: 0,
                    offset: Offset(0, 3)),
              ]),
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
          _businessProfile(),
        ],
      ),
    );
  }

  Widget _businessProfile() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextFieldWithImage(
          enable: widget.isUpdate ? !showEditButton : true,
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
          enable: widget.isUpdate ? !showEditButton : true,
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
          enable: widget.isUpdate ? !showEditButton : true,
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
          enable: widget.isUpdate ? !showEditButton : true,
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
          enable: widget.isUpdate ? !showEditButton : true,
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
          enable: widget.isUpdate ? !showEditButton : true,
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
            FocusScope.of(context).requestFocus(
                widget.isUpdate ? FocusNode() : businessEmailFocus);
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
          enable: widget.isUpdate ? false : true,
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
          _professionalProfile(),
        ],
      ),
    );
  }

  Widget _professionalProfile() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),

        MultiSelectDropDown(
          label: "Select Cuisine",
          isUpdate: widget.isUpdate,showEditButton: showEditButton,
          productList: cuisinesList,

        ),


        SizedBox(
          height: 20,
        ),
        TextFieldWithImage(
          enable: widget.isUpdate ? !showEditButton : true,
          onValidate: (val) {
            if (Condition.nonEmptyCondition(val)) {
              return "Provide Experience";
            }
            return null;
          },
          onChange: (val) {},
          errorMessage: "Provide Experience",
          focusNode: experienceFocus,
          controller: experienceController,
          onSubmit: (val) {
            FocusScope.of(context).requestFocus(FocusNode());
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
          onTap: (widget.isUpdate ? !showEditButton : true)
              ? _navigateToMap
              : null,
          width: MySize.of(context).fitWidth(80),
          controller: pickUpLocationController,
          errorMessage: "Please Provide Location",
          onValidate: (val) {
//            if (Condition.nonEmptyCondition(val)) {
//              return "Provide Business Name";
//            }
            return null;
          },
          label: "Location",
          isSuffixIcon: true,
          icon: Icons.map,
        ),
        SizedBox(
          height: 20,
        ),

        PopupTextField(
          showEditButton: showEditButton,
          isUpdate: widget.isUpdate,
          dataList: awardAndCertifications,
          deleteFun: (widget.isUpdate ? !showEditButton : true)?
            _deletePopDialogItem
          :null,
          labelDialog: "Item",
          labelTextField: "Awards and Certification",
          popDialog: _popDialog,
        ),


//        InkWell(
//          onTap:
//          (widget.isUpdate ? !showEditButton : true) ? _alertDialog : null,
//          child: Container(
//            width: MySize.of(context).fitWidth(80),
//            decoration: BoxDecoration(
//                border: Border(
//                    bottom: BorderSide(color: MColor.lightGreyB6, width: 1))),
//            padding: EdgeInsets.only(bottom: 5),
//            child: Stack(
//              children: <Widget>[
//                Center(
//                  child: Container(
////                      color:Colors.red,
//                    padding: EdgeInsets.only(right: 18, top: 5),
//                    width: MySize.of(context).fitWidth(80),
//                    child: Wrap(
//                        spacing: 4,
//                        children: awardsCertifications().length > 0
//                            ? awardsCertifications()
//                            : [
//                          Padding(
//                            padding: const EdgeInsets.only(top: 8.0),
//                            child: Text(
//                              "Awards and Certification".toUpperCase(),
//                              style: TextStyles.textStyleBold(
//                                  fontSize: 16, spacing: 4.0),
//                            ),
//                          ),
//                        ]),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),

        SizedBox(
          height: 20,
        ),

//          _imageSelectionProfessional(),
        Container(
            width: MySize.of(context).fitWidth(80),
            child: ImageSelectOrServer(
              _professionalImage,
              _callBackFromProfessionalImage,
              imageURL: chefDetailModel?.chef?.businessImage,
              enable: widget.isUpdate ? !showEditButton : true,
            )),

        SizedBox(
          height: 16,
        ),
      ],
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
          _verification(),
        ],
      ),
    );
  }

  Widget _verification() {
    return Column(
      children: <Widget>[
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
          enable: widget.isUpdate ? !showEditButton : true,
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
          controller: governmentIDCNICController,
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
              child: _govImage(frontFileImage, true),
            ),
            Expanded(
              child: _govImage(backFileImage, false),
            ),
          ],
        )
      ],
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
          _payment(),
        ],
      ),
    );
  }

  Widget _payment() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextFieldWithImage(
          enable: widget.isUpdate ? !showEditButton : true,
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
          enable: widget.isUpdate ? !showEditButton : true,
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
                child: submitDataLoading
                    ? Center(
                        child: Loading(),
                      )
                    : RoundedBorderButton(
                        text: currentIndex == totalIndexLength - 1
                            ? "Submit"
                            : "Next",
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
        if (_form1.currentState.validate()) {
          setState(() {
            currentIndex++;
          });
        }
        break;
      case 1:
        if (_form2.currentState.validate()) {
          print(_professionalImage == null);
          setState(() {
            currentIndex++;
          });
        }
        break;
      case 2:
        if (_form3.currentState.validate()) {
          setState(() {
            currentIndex++;
          });
        }
        break;
      case 3:
        if (_form4.currentState.validate()) {
          _submitToServerInsert();
        }
        break;
    }
  }

  _popDialog(List<String> awardsCertificates) {
    awardAndCertifications = awardsCertificates;
    setState(() {});
  }

  _deletePopDialogItem(text){

      awardAndCertifications.remove(text);
      setState(() {});
  }

  _callBackFromProfessionalImage(File file) {
    if (widget.isUpdate) {
      _professionalImage = file;
      _updateProfessionalImage();
    }else
      _professionalImage = file;
  }

  _takeImage(bool condition) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (condition)
        frontFileImage = image;
      else
        backFileImage = image;
      setState(() {});
    }
  }

  _navigateToMap() {
    CustomSnackBar.SnackBar_3Error(_scaffoldKey,
        leadingIcon: Icons.warning, title: "Comming Soon!");
  }

  _editSaveButton() {
    if (showEditButton) {
      setState(() {
        showEditButton = !showEditButton;
      });
    } else {
      _submitToServerUpdate();
    }
  }

  ///Server Call
  _submitToServerInsert() async {
    try {
      setState(() {
        submitDataLoading = true;
      });

      print(_professionalImage.path);

      FormData form = FormData.fromMap({
        "business_name": businessNameController.text,
        "business_email": businessEmailController.text,
        "business_phone": businessPhoneController.text,
        "experience": experienceController.text,
        "city": businessCityController.text,
        "state": businessStateController.text,
        "postal_code": businessPostalCodeController.text,
        "chef_description": "Comming Soon",
        "pickup_location": "Abbottabad",
        "latitude": "73.2407907",
        "longitude": "73.2407907",
        "business_address": businessAddressController.text,
        "cnic": governmentIDCNICController.text,
        "iban": ibanController.text,
        "bank_name": bankNameController.text
      });

      form.fields.addAll(
          awardAndCertifications.map((award) => MapEntry("awards[]", award)));

      form.fields.addAll(cuisinesList
          .where((cusine) => cusine.selected)
          .toList()
          .map((award) => MapEntry("cuisines[]", award.text)));

      form.files.add(MapEntry(
          "business_image",
          MultipartFile.fromFileSync(
            _professionalImage.path,
            filename: path.basename(_professionalImage.path),
          )));

      form.files.add(MapEntry(
          "cnic_front",
          MultipartFile.fromFileSync(
            frontFileImage.path,
            filename: path.basename(frontFileImage.path),
          )));

      form.files.add(MapEntry(
          "cnic_back",
          MultipartFile.fromFileSync(
            backFileImage.path,
            filename: path.basename(backFileImage.path),
          )));

      Response response = await API(_scaffoldKey)
          .post(url: CHEF_REGISTER_URL, body: form, contentType: "multipart/form-data");

      setState(() {
        submitDataLoading = false;
      });

      if (response != null) {
        ///Change User Role
        //
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("role", "2");

        ///Fetch User Again
        //
        UserInstance.instance.dispatch(ReloadUserData());
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        submitDataLoading = false;
      });
      print(e);
    }
  }

  _submitToServerUpdate() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        submitDataLoading = true;
      });



      Map map = {
        "business_name": businessNameController.text,
        "business_email": businessEmailController.text,
        "business_phone": businessPhoneController.text,
        "experience": double.parse(experienceController.text).floor(),
        "city": businessCityController.text,
        "state": businessStateController.text,
        "postal_code": businessPostalCodeController.text,
        "chef_description": "Comming Soon",
        "pickup_location": "Abbottabad",
        "latitude": "73.2407907",
        "longitude": "73.2407907",
        "business_address": businessAddressController.text,
        "cnic": governmentIDCNICController.text,
        "iban": ibanController.text,
        "bank_name": bankNameController.text
      };


      map.addAll({"awards":awardAndCertifications.map((award)=>award).toList()});
      map.addAll({"cuisines":cuisinesList.where((cusine) => cusine.selected).toList().map((cusine)=>cusine.text).toList()});

//      form.addEntries(
//          awardAndCertifications.map((award) => MapEntry("awards[]", award)));
//
//      form.addEntries(cuisinesList
//          .where((cusine) => cusine.isSelected)
//          .toList()
//          .map((award) => MapEntry("cuisines[]", award.text)));
//
//
//      form.fields.forEach((entry){
//        print("${entry.key} ${entry.value}");
//      });



      Response response = await API(_scaffoldKey)
          .put(url: CHEF_UPDATE_URL, body: map, contentType: "application/x-www-form-urlencoded");

      setState(() {
        submitDataLoading = false;
      });

      if (response != null) {
        UserInstance.instance.dispatch(ReloadUserData());

        CustomSnackBar.SnackBar_3Success(_scaffoldKey,
            title: "Chef Updated Successfully!", leadingIcon: Icons.check);

        setState(() {
          showEditButton = true;
        });

//        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        submitDataLoading = false;
      });
      print(e);
    }
  }

  _updateProfessionalImage() async{
    try {
      setState(() {
        submitDataLoading = true;
      });

      print(_professionalImage.path);

      FormData form = FormData.fromMap({

      });



      form.files.add(MapEntry(
          "business_image",
          MultipartFile.fromFileSync(
            _professionalImage.path,
            filename: path.basename(_professionalImage.path),
          )));



      Response response = await API(_scaffoldKey)
          .post(url: CHEF_UPDATE_IMAGE_URL, body: form, contentType: "multipart/form-data");

      setState(() {
        submitDataLoading = false;
      });

      if (response != null) {


        ///Fetch User Again
        //
        UserInstance.instance.dispatch(ReloadUserData());

      }else{
        setState(() {
          _professionalImage=null;

        });
      }
    } catch (e) {
      setState(() {
        submitDataLoading = false;
      });
      print(e);
    }
  }
}


