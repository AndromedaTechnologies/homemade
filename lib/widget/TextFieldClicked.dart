import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';

class TextFieldClicked extends StatelessWidget {
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

  final bool obscureText;
  final bool removeImageIcon;
  final bool isSuffixIcon;

  final Function onChange;
  final Function onValidate;
  final Function onSubmit;
  final Function onTap;

  TextFieldClicked(
      {this.focusNode,
      this.textInputType,
      this.controller,
      this.action,
      this.errorMessage,
      this.imagePath,
      this.width,
      this.label,
      this.onTap,
      this.hint,
      this.preFixImage,
      this.icon,
      this.isSuffixIcon = false,
      this.obscureText = false,
      this.onChange,
      this.onSubmit,
      this.removeImageIcon = false,
      this.onValidate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        child: TextFormField(
          enabled: false,
          controller: controller,
          style: TextStyles.textStyleNormalGrey(),
          cursorColor: MColor.application,
          focusNode: focusNode,
          onChanged: onChange,
          validator: onValidate,
          onFieldSubmitted: onSubmit,
          decoration: InputDecoration(
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: MColor.lightGreyB6),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: MColor.lightGreyB6),
              ),
              enabled: false,
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
                      : Image.asset(
                          imagePath,
                          height: 16,
                          width: 16,
                        )),
        ),
      ),
    );
  }
}
