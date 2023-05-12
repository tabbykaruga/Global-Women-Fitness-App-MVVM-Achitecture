import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/resources/fontManager.dart';


TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}
//passing 2 argument the font size and color

//regular style
TextStyle getRegularStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

//light style
TextStyle getLightStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}

//Medium style
TextStyle getMediumStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}

//Bold style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

//Bold style
TextStyle getBoldStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}
