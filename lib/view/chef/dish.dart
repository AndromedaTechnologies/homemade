import 'package:flutter/material.dart';

class DishAddUpdateView extends StatefulWidget {
  final bool isUpdate;

  DishAddUpdateView({this.isUpdate});

  @override
  _DishAddUpdateViewState createState() => _DishAddUpdateViewState();
}

class _DishAddUpdateViewState extends State<DishAddUpdateView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  GlobalKey<FormState> _form2 = GlobalKey<FormState>();


  TextEditingController itemNameController;
  TextEditingController priceController;
  TextEditingController descriptionController;

  String servingSize;
  String cuisineType;
  String dietaryInfo;
  String courseType;
  String spice;
  String dishIngredient;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
