import 'package:flutter/material.dart';
import 'package:homemade/model/UserModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';

class ImageInitials extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageURL;
  final double width;
  final double height;
  final double fontSize;

  ImageInitials(
      {this.firstName,
      this.lastName,
      this.imageURL,
      this.width = 75,
      this.height = 75,
      this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,

      decoration:
          BoxDecoration(shape: BoxShape.circle, color: MColor.application),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: imageURL == null || imageURL == ""
            ? Text(
                UserModel.getInitials(firstName, lastName),
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyles.textStyleBoldWhite(fontSize: fontSize,spacing: 1),
              )
            : Image.network(
                imageURL,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
      ),
    );
  }
}
