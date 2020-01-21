import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class SearchTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction action;

  final double width;

  final String label;
  final String hint;
  final String errorMessage;

  final Function onChange;
  final Function onValidate;
  final Function onSubmit;

  SearchTextField({
    this.focusNode,
    this.textInputType,
    this.controller,
    this.action,
    this.errorMessage,
    this.width,
    this.label,
    this.hint,
    this.onChange,
    this.onSubmit,
    this.onValidate,
  });

  ///Error message inside Container
  ///Error message below textfields

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      child: TextFormField(
        controller: controller,
        style: TextStyles.textStyleNormalGrey(),
        cursorColor: MColor.application,
        focusNode: focusNode,
        keyboardType: textInputType,
        onChanged: onChange,
        validator: onValidate,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          border: InputBorder.none,

//          contentPadding: EdgeInsets.only(
//            top: 0,
//            bottom: 10,
//            left: 5,
//            right: 5
//          ),
          errorStyle: TextStyles.textStyleError(),
//            errorText: errorMessage,
          labelText: label?.toUpperCase(),
          labelStyle: TextStyles.textStyleBold(fontSize: 16, spacing: 4.0),
          hintText: hint,

          hintStyle: TextStyles.textStyleNormal().copyWith(color: MColor.application.withOpacity(0.8)),
        ),
      ),
    );
  }
}
