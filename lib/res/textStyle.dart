import 'package:flutter/material.dart';
import 'package:homemade/res/size.dart';

import 'color.dart';

class TextStyles {
  static const String FONT_FAMILY = '';
  static const FontWeight FONT_WEIGHT_NORMAL = FontWeight.w400;
  static const FontWeight FONT_WEIGHT_BOLD = FontWeight.bold;
  static const FontWeight FONT_WEIGHT_HARD_BOLD = FontWeight.w900;
  static const FontWeight FONT_WEIGHT_SEMI_BOLD = FontWeight.w500;
  static const FontWeight FONT_WEIGHT_LIGHT = FontWeight.w300;

  static TextStyle textStyleBold(
      {double fontSize = 18.0, double spacing = 0.6}) {
    return TextStyle(
      color: MColor.application,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }

  static TextStyle textStyleBoldGrey(
      {double fontSize = 16.0, double spacing = 0.6}) {
    return TextStyle(
      color: MColor.lightGreyB6,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }

  static TextStyle textStyleHardBold(
      {double fontSize = 18.0, double spacing = 0.6}) {
    return TextStyle(
      color: MColor.application,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_HARD_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }
 static TextStyle textStyleHardBoldGrey(
      {double fontSize = 18.0, double spacing = 0.6}) {
    return TextStyle(
      color: MColor.lightGreyB6,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_HARD_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }

  static TextStyle textStyleBoldWhite(
      {double fontSize = 18.0, double spacing = 0.4}) {
    return TextStyle(
      color: MColor.white,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }

  static TextStyle textStyleNormalDarkGreyBold(
      {double fontSize = 18.0, double spacing = 0.4}) {
    return TextStyle(
      color: MColor.darkGrey,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }

  static TextStyle textStyleBoldItalic({double fontSize = 18.0}) {
    return TextStyle(
        color: MColor.application,
        fontSize: fontSize,
        fontWeight: FONT_WEIGHT_BOLD,
        fontFamily: FONT_FAMILY,
        letterSpacing: 0.4,
        fontStyle: FontStyle.italic);
  }

  static TextStyle textStyleLightItalic({double fontSize = 18.0}) {
    return TextStyle(
        color: MColor.application,
        fontSize: fontSize,
        fontWeight: FONT_WEIGHT_LIGHT,
        fontFamily: FONT_FAMILY,
        letterSpacing: 0.2,
        fontStyle: FontStyle.italic);
  }

  static TextStyle textStyleLightItalicWhite(
      {double fontSize = 18.0, double letterSpacing}) {
    return TextStyle(
        color: MColor.white,
        fontSize: fontSize,
        fontWeight: FONT_WEIGHT_LIGHT,
        fontFamily: FONT_FAMILY,
        letterSpacing: letterSpacing ?? 0.2,
        fontStyle: FontStyle.italic);
  }

  static TextStyle textStyleNormalSemiBold({double fontSize = 16.0}) {
    return TextStyle(
      color: MColor.application,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_SEMI_BOLD,
      fontFamily: FONT_FAMILY,
    );
  }

  static TextStyle textStyleNormalGreySemiBold({double fontSize = 16.0}) {
    return TextStyle(
      color: MColor.lightGreyB6,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_SEMI_BOLD,
      fontFamily: FONT_FAMILY,
    );
  }

  static TextStyle textStyleNormalDarkGreySemiBold({double fontSize = 16.0}) {
    return TextStyle(
      color: MColor.darkGrey,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_SEMI_BOLD,
      fontFamily: FONT_FAMILY,
    );
  }

  static TextStyle textStyleNormalLightItalic(
      {double fontSize = 16.0, double letterSpacing = 0.2}) {
    return TextStyle(
        color: MColor.application,
        fontSize: fontSize,
        fontWeight: FONT_WEIGHT_NORMAL,
        fontFamily: FONT_FAMILY,
        letterSpacing: letterSpacing,
        fontStyle: FontStyle.italic);
  }

  static TextStyle textStyleNormal({double fontSize = 16.0}) {
    return TextStyle(
      color: MColor.application,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_NORMAL,
      fontFamily: FONT_FAMILY,
    );
  }

  static TextStyle textStyleNormalGrey(
      {double fontSize = 16.0, double letterSpacing = 0.2}) {
    return TextStyle(
        color: MColor.lightGreyB6,
        fontSize: fontSize,
        fontWeight: FONT_WEIGHT_NORMAL,
        fontFamily: FONT_FAMILY,
        letterSpacing: letterSpacing ?? 0.2);
  }

  static TextStyle textStyleNormalWhite({double fontSize = 16.0}) {
    return TextStyle(
      color: MColor.white,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_NORMAL,
      fontFamily: FONT_FAMILY,
    );
  }

  static TextStyle textStyleNormalDarkGrey({double fontSize = 16.0}) {
    return TextStyle(
      color: MColor.darkGrey,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_NORMAL,
      fontFamily: FONT_FAMILY,
    );
  }

  static TextStyle textStyleError({double fontSize = 14.0}) {
    return TextStyle(
        color: MColor.error,
        fontSize: fontSize,
        fontWeight: FONT_WEIGHT_NORMAL,
        fontFamily: FONT_FAMILY,
        letterSpacing: 0.2,
        fontStyle: FontStyle.italic);
  }

  static TextStyle textStyleStarBold(
      {double fontSize = 16.0, double spacing = 0.2}) {
    return TextStyle(
      color: MColor.starYellow,
      fontSize: fontSize,
      fontWeight: FONT_WEIGHT_BOLD,
      fontFamily: FONT_FAMILY,
      letterSpacing: spacing,
    );
  }
}
