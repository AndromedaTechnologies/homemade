
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class OutlineBorderButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double width;
  final double height;
  final Color borderColor;
  final TextStyles textStyle;

  OutlineBorderButton({this.text, this.onTap, this.width, this.borderColor,this.height,this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width?? MySize.of(context).fitWidth(80),
        height: height??60,
        decoration: BoxDecoration(
          color: MColor.application.withOpacity(0.0),
          borderRadius: BorderRadius.circular(200),
          border: Border.all(
            color: borderColor??MColor.white,
            width: 2.0
          )
        ),
        child: Center(child: Text(
          text.toUpperCase(),
          style: textStyle?? TextStyles.textStyleBoldWhite(),
        )),


      ),
    );
  }
}
