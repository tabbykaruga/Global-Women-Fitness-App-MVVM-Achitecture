import 'package:flutter/material.dart';

class ColorManager{
  static Color primary = HexColor.fromHex("#FCE4EC");
  static Color pink1 = HexColor.fromHex("#FF8197");
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9727");

  static Color darkPrimary = HexColor.fromHex("#E91E63");
  static Color grey1 = HexColor.fromHex('#707070');
  static Color grey2 = HexColor.fromHex("#797979");
  static Color blue = HexColor.fromHex("#374B9B");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
}
extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');

    if(hexColorString.length == 6){
      hexColorString = "FF$hexColorString"; //-> "FF" + hexColorString
    }
    return Color(int.parse(hexColorString,radix: 16));
  }

}