import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homemade/dropdownClass/course.dart';
import 'package:homemade/dropdownClass/cuisine.dart';
import 'package:homemade/dropdownClass/dietary.dart';
import 'package:homemade/dropdownClass/serving.dart';
import 'package:homemade/dropdownClass/servingtime.dart';
import 'package:homemade/dropdownClass/spice.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/model/imageModel.dart';
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
  final DishModel dishModel;

  DishAddUpdateView({this.isUpdate = false, this.dishModel});

  @override
  _DishAddUpdateViewState createState() => _DishAddUpdateViewState();
}

class _DishAddUpdateViewState extends State<DishAddUpdateView>
    with SingleTickerProviderStateMixin {
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
  bool showEditButton = false;
  bool dropDownError = false;

  List<String> dishIngredients = [];
  List<File> dishImages = [null, null, null, null];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
//      _tabController.
    });

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

    if (widget.isUpdate) _loadPreData();
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
              text: "Information 1",
            ),
            Tab(
              text: "Information 2",
            ),
            Tab(
              text: "Images",
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
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
                    text: "Save",
                    borderRadius: 5,
                    height: 35,
                    onTap: _submitToServerUpdate,
                  ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(
                child: _disInformation_1(),
              ),
              SingleChildScrollView(
                child: _disInformation_2(),
              ),
              SingleChildScrollView(
                child: _dishImages(),
              ),
            ]),
          ),
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
          hasError: dropDownError && servingSize == null,
          errorText: "Please Select Serving Size",
          listData: servingList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              servingSize =
                  servingList.where((item) => item.text == val).first.text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Cuisine Type",
          selectedValue: cuisineType,
          hasError: dropDownError && cuisineType == null,
          errorText: "Please Select Cuisine type",
          listData: cuisinesList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              cuisineType =
                  cuisinesList.where((item) => item.text == val).first.text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Dietary Info",
          selectedValue: dietaryInfo?.trim(),
          hasError: dropDownError && dietaryInfo == null,
          errorText: "Please Select Dietry Info",
          listData: dietaryList.map((item) => item.text.trim()).toList(),
          onChangeFun: (val) {
            setState(() {
              dietaryInfo =
                  dietaryList.where((item) => item.text == val).first.text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomDropDown(
          hintText: "Course Type",
          selectedValue: courseType,
          hasError: dropDownError && courseType == null,
          errorText: "Please Select Course Type",
          listData: courseList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              courseType =
                  courseList.where((item) => item.text == val).first.text;
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
    return Column(
      children: <Widget>[
        CustomDropDown(
          hintText: "Spice",
          selectedValue: spice,
          errorText: "Please Select Spice",
          hasError: dropDownError && spice == null,
          listData: spiceList.map((item) => item.text).toList(),
          onChangeFun: (val) {
            setState(() {
              spice = spiceList.where((item) => item.text == val).first.text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        MultiSelectDropDown(
          label: "Serving time",
          width: double.maxFinite,
          isUpdate: widget.isUpdate,
          showEditButton: showEditButton,
          productList: servingTimeList,
          hasError: dropDownError &&
              servingTimeList.where((serv) => serv.selected).toList().length ==
                  0,
          errorText: "Please Select Serving Time",
          okayButton: () {
            Navigator.of(context).pop();
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(
          height: 20,
        ),
        PopupTextField(
          width: double.maxFinite,
          showEditButton: showEditButton,
          isUpdate: widget.isUpdate,
          hasError: dropDownError && dishIngredients.length == 0,
          errorText: "Please Add Ingredient",
          dataList: dishIngredients,
          deleteFun: (widget.isUpdate ? !showEditButton : true)
              ? _deletePopDialogItem
              : null,
          labelDialog: "Ingredient",
          labelTextField: "Dish Ingredients",
          popDialog: _popDialog,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _stepperThree() {
    return Column(
      children: <Widget>[
        _stepperHeading("Dish Images"),
        SizedBox(
          height: 20,
        ),
        Text(
          "${widget.isUpdate ? "Update" : "Add"} image of your Dish to attrat Foodies. Images gives better idea of your dish.",
          textAlign: TextAlign.center,
          style: TextStyles.textStyleNormalGrey(fontSize: 14),
        ),
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
      alignment: WrapAlignment.center,
      children: widget.isUpdate
          ? widget.dishModel.dishimages
              .map((image) => _dishImageUpdate(image))
              .toList()
          : dishImages.map((file) => _dishImage(file)).toList(),
    );
  }

  Widget _dishImageUpdate(DishImageModel imageModel) {
    return imageModel?.image == null
        ? Container(
            child: Center(child: Loading()),
            width: 120,
            height: 100,
          )
        : InkWell(
            onTap: () {
              _updateImage(imageModel);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 100,
                  image: NetworkImage(imageModel.image)),
            ),
          );
  }

  Widget _dishImage(File file) {
    return file == null
        ? _dishAddImage(dishImages.indexOf(file))
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                fit: BoxFit.cover,
                width: 120,
                height: 100,
                image: FileImage(file)),
          );
  }

  Widget _dishAddImage(int index) {
    return InkWell(
      onTap: () {
        _addDishImage(index);
      },
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MColor.lightGreyB6, width: 1.3)),
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
    setState(() {
      dropDownError = false;
    });
    switch (currentIndex) {
      case 0:
        if (_form1.currentState.validate()) {
          if (_validateDropDown()) {
            setState(() {
              currentIndex++;
            });
          } else {
            setState(() {
              dropDownError = true;
            });
          }
        }
        break;
      case 1:
        if (_form2.currentState.validate()) {
          if (_validateDropDown2()) {
            setState(() {
              currentIndex++;
            });
          } else {
            setState(() {
              dropDownError = true;
            });
          }
        }
        break;
      case 2:
        _submitToServerInsert();
        break;
    }
  }

  _validateDropDown() {
    return !(servingSize == null ||
        cuisineType == null ||
        dietaryInfo == null ||
        courseType == null);
  }

  _validateDropDown2() {
    return !(spice == null ||
        servingTimeList.map((serv) => serv.selected).toList().length == 0 ||
        dishIngredients.length == 0);
  }

  _popDialog(List<String> ingredient) {
    dishIngredients = ingredient;
    setState(() {});
  }

  _deletePopDialogItem(text) {
    dishIngredients.remove(text);
    setState(() {});
  }

  _addDishImage(int index) async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      dishImages[index] = image;
      setState(() {});
    }
  }

  _loadPreData() {
    itemNameController.text = widget.dishModel.name;
    priceController.text = widget.dishModel.price;
    descriptionController.text = widget.dishModel.description;
    servingSize = widget.dishModel.servingSize;
    cuisineType = widget.dishModel.cuisineType;
    dietaryInfo = widget.dishModel.dietaryInformation;
    courseType = widget.dishModel.courseType;
//    spice = widget.dishModel.

    dishIngredients = widget.dishModel.ingredients;
    widget.dishModel.servingtime.forEach((time) {
      try {
        servingTimeList
            .where((servTime) => servTime.text == time)
            .first
            .selected = true;
      } catch (e) {}
    });
  }

  ///Server
  _submitToServerInsert() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        submitDataLoading = true;
      });

      FormData form = FormData.fromMap({
        "name": itemNameController.text,
        "price": priceController.text,
        "serving_size": servingSize,
        "cuisine_type": cuisineType,
        "dietary_information": dietaryInfo,
        "course_type": courseType,
        "description": descriptionController.text,
        "servingtime": servingTimeList.map((serving) => serving.text).toList()
      });

      dishIngredients.forEach((ing) {
//        "ingredients": dishIngredients,
        form.fields.add(MapEntry("ingredients[]", ing));
      });

      dishImages.forEach((file) {
        form.files.add(MapEntry(
            "dishimages[]",
            MultipartFile.fromFileSync(
              file.path,
              filename: path.basename(file.path),
            )));
      });

      print(form.files.map((item) => item.key).toList());

      Response response = await API(_scaffoldKey).post(
          url: CHEF_DISH_URL, body: form, contentType: "multipart/form-data");

      if (response != null) {
        String message = response.data['message'];
        Navigator.of(context).pop(message ?? "success");
      } else {
        throw Exception();
      }
    } catch (e) {
      setState(() {
        submitDataLoading = false;
      });
      print(e);
    }
  }

  _updateImage(DishImageModel imageModel) async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _updateImageServer(imageModel, image);
    }
  }

  _updateImageServer(DishImageModel imageModel, File image) async {
    try {
      String preImageUrl = imageModel.image;
      setState(() {
        imageModel.image = null;
      });

      FormData form = FormData.fromMap({"id": imageModel.id});
      form.files.add(MapEntry(
          "dishimages",
          MultipartFile.fromFileSync(
            image.path,
            filename: path.basename(image.path),
          )));

      Response response = await API(_scaffoldKey).post(
          url: CHEF_DISH_IMAGE_UPDATE,
          body: form,
          contentType: "multipart/form-data");

      if (response != null) {
        setState(() {
          imageModel.image = response.data['dish'];
        });
      } else {
        setState(() {
          imageModel.image = preImageUrl;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _submitToServerUpdate() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        submitDataLoading = true;
      });

      Map form = {
        "id": widget.dishModel.id,
        "name": itemNameController.text,
        "price": priceController.text,
        "serving_size": servingSize,
        "cuisine_type": cuisineType,
        "dietary_information": dietaryInfo,
        "course_type": courseType,
        "description": descriptionController.text,
        "servingtime": servingTimeList.map((serving) => serving.text).toList(),
        "ingredients": dishIngredients.map((ingredient) => ingredient).toList()
      };

      Response response = await API(_scaffoldKey).put(
          url: CHEF_DISH_UPDATE,
          body: form,
          contentType: "application/x-www-form-urlencoded");

      if (response != null) {
//        DishModel responseModel = DishModel.fromJson(response.data);
//        print(responseModel.name);


        Navigator.of(context).pop();
        Navigator.of(context).pop("yes");
      } else {
        throw Exception();
      }
    } catch (e) {
      setState(() {
        submitDataLoading = false;
      });
      print(e);
    }
  }
}
