
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class ErrorMessage extends StatelessWidget {

  final String errorMessage;

  ErrorMessage(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: TextStyles.textStyleError(),
    );
  }
}
