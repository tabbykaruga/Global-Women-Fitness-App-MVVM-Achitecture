import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/presentation/resources/colorManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/fontManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/styleManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/valueManager.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
      //main color for the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1, //used in case of disabled button
      splashColor: ColorManager.primaryOpacity70, //ripple color

      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white, fontSize: FontSizeManager.s16),
      ),
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey,
        splashColor: ColorManager.primaryOpacity70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s12)))),
      ),
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.blue, fontSize: FontSizeManager.s16),
          titleMedium: getMediumStyle(
              color: ColorManager.grey, fontSize: FontSizeManager.s14),
          titleSmall: getMediumStyle(
              color: ColorManager.blue, fontSize: FontSizeManager.s14),
          bodySmall: getRegularStyle(color: ColorManager.grey1),
          headlineSmall: getBoldStyle(color: ColorManager.pink1,fontSize: FontSizeManager.s16 ),
          bodyLarge: getRegularStyle(color: ColorManager.grey)),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManager.grey1),
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.grey,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //focus
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.pink1,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //error
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.error,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //focus error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.error,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ),
  );
}
