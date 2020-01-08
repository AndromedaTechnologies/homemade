import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class TextFieldWithImage extends StatelessWidget {
  final FocusNode focusNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction action;
  final IconData icon;

  final double width;

  final String label;
  final String hint;
  final String preFixImage;
  final String errorMessage;
  final String imagePath;
  final String suffixLabel;

  final bool obscureText;
  final bool removeImageIcon;
  final bool isSuffixIcon;
  final bool enable;
  final bool isSuffixLabel;

  final Function onChange;
  final Function onValidate;
  final Function onSubmit;
  final bool isMultiLine;

  TextFieldWithImage(
      {this.focusNode,
      this.textInputType,
      this.controller,
      this.suffixLabel,
      this.action,
      this.errorMessage,
      this.isSuffixLabel = false,
      this.imagePath,
      this.width,
      this.isSuffixIcon: false,
      this.icon,
      this.label,
      this.hint,
      this.isMultiLine=false,
      this.preFixImage,
      this.obscureText = false,
      this.onChange,
      this.onSubmit,
      this.removeImageIcon = false,
      this.onValidate, this.enable=true});

  ///Error message inside Container
  ///Error message below textfields

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      child: TextFormField(
        enabled: enable,
        controller: controller,
        style: TextStyles.textStyleNormalGrey(),
        cursorColor: MColor.application,
        focusNode: focusNode,
        keyboardType: textInputType,
        obscureText: obscureText,
        onChanged: onChange,
        validator: onValidate,
        onFieldSubmitted: onSubmit,
        maxLines: isMultiLine? 5: null,

        decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: MColor.lightGreyB6),
            ),

//          contentPadding: EdgeInsets.only(
//            top: 0,
//            bottom: 10,
//            left: 5,
//            right: 5
//          ),
            errorStyle: TextStyles.textStyleError(),
//            errorText: errorMessage,
            labelText: label.toUpperCase(),
            labelStyle: TextStyles.textStyleBold(fontSize: 16, spacing: 4.0),
            hintText: hint,

            hintStyle: TextStyles.textStyleNormalGrey(),
            suffixIcon: removeImageIcon
                ? null
                : isSuffixIcon
                    ? Icon(
                        icon,
                        size: 24,
                        color: MColor.lightGreyB6,
                      )
                    : isSuffixLabel
                        ? Container(
                            width: 80,
                            child: Center(
                              child: Text(
                                suffixLabel,
                                style: TextStyles.textStyleNormalGrey(
                                    fontSize: 16),
                              ),
                            ),
                          )
                        : Image.asset(
                            imagePath,
                            height: 16,
                            width: 16,
                          )),
      ),
    );
  }
}
