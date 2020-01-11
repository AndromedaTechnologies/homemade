import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homemade/dropdownClass/course.dart';
import 'package:homemade/dropdownClass/cuisine.dart';
import 'package:homemade/dropdownClass/dietary.dart';
import 'package:homemade/dropdownClass/serving.dart';
import 'package:homemade/dropdownClass/servingtime.dart';
import 'package:homemade/dropdownClass/spice.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/stringapi.dart';
import 'package:homemade/res/textFieldConditions.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/server/GeneralAPI.dart';
import 'package:homemade/widget/MultiSelectDropDown.dart';
import 'package:homemade/widget/PopupTextField.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';
import 'package:homemade/widget/customDropDown.dart';
import 'package:homemade/widget/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:path/path.dart' as path;

class DishAddUpdateView extends StatefulWidget {
  final bool isUpdate;

  DishAddUpdateView({this.isUpdate = false});

  @override
  _DishAddUpdateViewState createState() => _DishAddUpdateViewState();
}

class _DishAddUpdateViewState extends State<DishAddUpdateView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  GlobalKey<FormState> _form2 = GlobalKey<FormState>();

  TabController _tabController;

  int currentIndex = 0;
  int totalIndexLength = 3;

  TextEditingController itemNameController;
  TextEditingController priceController;
  TextEditingController descriptionController;

  String servingSize;
  String cuisineType;
  String dietaryInfo;
  String courseType;
  String spice;

  bool submitDataLoading = false;
  bool showEditButton = true;

  List<String> dishIngredients = [];
  List<File> dishImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseList.forEach((item) {
      item.selected = false;
    });
    cuisinesList.forEach((item) {
      item.selected = false;
    });
    dietaryList.forEach((item) {
      item.selected = false;
    });
    servingList.forEach((item) {
      item.selected = false;
    });
    servingTimeList.forEach((item) {
      item.selected = false;
    });
    spiceList.forEach((item) {
      item.selected = false;
    });

    itemNameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    courseList.forEach((item) {
      item.selected = false;
    });
    cuisinesList.forEach((item) {
      item.selected = false;
    });
    dietaryList.forEach((item) {
      item.selected = false;
    });
    servingList.forEach((item) {
      item.selected = false;
    });
    servingTimeList.forEach((item) {
      item.selected = false;
    });
    spiceList.forEach((item) {
      item.selected = false;
    });
    super.dispose();
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
    return Container();
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
            "Add Dish",
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
      default:
        return Container();
    }
  }

  Widget _stepperOne() {
    return Form(
      key: _form1,
      child: Column(
        children: <Widget>[
          _stepperHeading("Dish Information 1"),
          SizedBox(
            height: 20,
          ),
          _disInformation_1(),
        ],
      ),
    );
  }

  Widget _disInformation_1() {
    return Column(
      children: <Widget>[
        TextFieldWithImage(
          enable: widget.isUpdate ? !showEditButton : true,
          onValidate: (val) {
            if (Condition.nonEmptyCondition(val)) {
              return "Item Name";
            }
            return null;
          },
          removeImageIcon: true,
          onChange: (val) {},
          errorMessage: "Provide Item Name",
//          focusNode: itemNameController,
          controller: itemNameController,
          onSubmit: (val) {
//            FocusScope.of(context).requestFocus();
            setState(() {});
          },
          width: MySize.of(context).fitWidth(80),
          obscureText: false,
          textInputType: TextInputType.text,
          action: TextInputAction.next,
          hint: "-",
          label: "Item Name",
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldWithImage(
          enable: widget.isUpdate ? !showEditButton : true,
          onValidate: (val) {
            if (Condition.nonEmptyCondition(val)) {
              return "Dish Price";
            }
            return null;
          },
          removeImageIcon: true,
          onChange: (val) {},
          errorMessage: "Provide Dish Price",
//          focusNode: itemNameController,
          controller: priceController,
          onSubmit: (val) {
//            FocusScope.of(context).requestFocus();
            setState(() {});
          },
          width: MySize.of(context).fitWidth(80),
          obscureText: false,
          textInputType: TextInputType.number,
          action: TextInputAction.next,
          hint: "-",
          label: "Dish Price",
          imagePath: logoImage,
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Serving size",
          selectedValue: servingSize,
          listData: servingList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              servingSize =
                  servingList
                      .where((item) => item.text == val)
                      .first
                      .text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Cuisine Type",
          selectedValue: cuisineType,
          listData: cuisinesList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              cuisineType =
                  cuisinesList
                      .where((item) => item.text == val)
                      .first
                      .text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Dietary Info",
          selectedValue: dietaryInfo,
          listData: dietaryList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              dietaryInfo =
                  dietaryList
                      .where((item) => item.text == val)
                      .first
                      .text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Course Type",
          selectedValue: courseType,
          listData: courseList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              courseType =
                  courseList
                      .where((item) => item.text == val)
                      .first
                      .text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldWithImage(
          enable: widget.isUpdate ? !showEditButton : true,
          onValidate: (val) {
            if (Condition.nonEmptyCondition(val)) {
              return "Provide Item Description";
            }
            return null;
          },
          removeImageIcon: true,
          isMultiLine: true,
          onChange: (val) {},
          errorMessage: "Provide Item Description",
//          focusNode: itemNameController,
          controller: descriptionController,
          onSubmit: (val) {
//            FocusScope.of(context).requestFocus();
            setState(() {});
          },
          width: MySize.of(context).fitWidth(80),
          obscureText: false,
          textInputType: TextInputType.text,
          action: TextInputAction.next,
          hint: "-",
          label: "Item Description",
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _stepperTwo() {
    return Form(
      key: _form2,
      child: Column(
        children: <Widget>[
          _stepperHeading("Dish Information 2"),
          SizedBox(
            height: 20,
          ),
          _disInformation_2(),
        ],
      ),
    );
  }

  Widget _disInformation_2() {
    return Column(children: <Widget>[

      CustomDropDown(
        hintText: "Spice",
        selectedValue: spice,
        listData: spiceList.map((item) => item.text).toList(),
        onChangeFun: (val) {
          setState(() {
            spice =
                spiceList
                    .where((item) => item.text == val)
                    .first
                    .text;
          });
        },
      ),
      SizedBox(
        height: 20,
      ),
      MultiSelectDropDown(
        label: "Serving time",
        isUpdate: widget.isUpdate, showEditButton: showEditButton,
        productList: servingTimeList,

      ),

      SizedBox(
        height: 20,
      ),

      PopupTextField(
        showEditButton: showEditButton,
        isUpdate: widget.isUpdate,
        dataList: dishIngredients,
        deleteFun: (widget.isUpdate ? !showEditButton : true) ?
        _deletePopDialogItem
            : null,
        labelDialog: "Ingredient",
        labelTextField: "Dish Ingredients",
        popDialog: _popDialog,
      ),

      SizedBox(
        height: 20,
      ),

    ],);
  }

  Widget _stepperThree() {
    return Column(
      children: <Widget>[
        _stepperHeading("Dish Images"),
        SizedBox(
          height: 20,
        ),

        Text(
          "Add image of your Dish to attrat Foodies. Images gives better idea of your dish.",
          textAlign: TextAlign.center,
          style: TextStyles.textStyleNormalGrey(fontSize: 14),),
        SizedBox(
          height: 20,
        ),
        _dishImages(),
      ],
    );
  }

  Widget _dishImages() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: dishImages.map((file) => _dishImage(file)).toList()
        ..add(_dishAddImage()),
    );
  }

  Widget _dishImage(File file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          fit: BoxFit.cover,
          width: 120,
          height: 100,
          image: FileImage(file)),
    );
  }

  Widget _dishAddImage() {
    return InkWell(
      onTap: _addDishImage,
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MColor.lightGreyB6, width: 1.3)
        ),

        child: Icon(
          Icons.add_photo_alternate,
          color: MColor.application,
          size: 60,
        ),
      ),
    );
  }

  Widget _stepperHeading(String heading) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Text(
            heading ?? "",
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
        setState(() {
          currentIndex++;
        });
//        }
        break;
      case 2:
        _submitToServerInsert();
        break;
    }
  }

  _popDialog(List<String> ingredient) {
    dishIngredients = ingredient;
    setState(() {});
  }

  _deletePopDialogItem(text) {
    dishIngredients.remove(text);
    setState(() {});
  }

  _addDishImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,);
    if (image != null) {
      dishImages.add(image);
      setState(() {});
    }
  }

  ///Server
  _submitToServerInsert() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
//      setState(() {
//        submitDataLoading = true;
//      });

      FormData form = FormData.fromMap({
        "name": itemNameController.text,
        "price": priceController.text,
        "serving_size": servingSize,
        "cusine_type": cuisineType,
        "dietary_information": dietaryInfo,
        "course_type": courseType,
        "description": descriptionController.text,
        "servingtime": servingTimeList.map((serving)=>serving.text).toList()
      });

      dishIngredients.forEach((ing){
//        "ingredients": dishIngredients,
        form.fields.add(MapEntry("ingredients[]", ing));
      });

      dishImages.forEach((file){
        form.files.add(MapEntry(
            "dishimages[]",
            MultipartFile.fromFileSync(
              file.path,
              filename: path.basename(file.path),
            )
        ));
      });

      print(form.files.map((item)=>item.key).toList());

      Response response = await API(_scaffoldKey)
          .post(url: CHEF_DISH_URL, body: form, contentType: "multipart/form-data");


      if(response.statusCode==200){
        String message = response.data['message'];
        Navigator.of(context).pop(message??"success");
      }


    }catch(e){
    setState(() {
    submitDataLoading = false;
    });
    print(e);

    }

  }
}
