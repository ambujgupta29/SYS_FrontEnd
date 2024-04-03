import 'dart:ui';

import 'package:flutter/material.dart';

enum SysAppThemes{light, lightHC, dark}

class SysAppTheme{
  SysAppThemes currentTheme = SysAppThemes.light; // do not use this elsewhere

  SysAppThemes current() => currentTheme;

  bool isLightTheme() => currentTheme == SysAppThemes.light;
  bool isLightHCTheme() => currentTheme == SysAppThemes.lightHC;
  bool isDarkTheme() => currentTheme == SysAppThemes.dark;
  bool isThemeEquals(SysAppThemes theme) => currentTheme == theme;

  // Color black = const Color(0xff121212);
  // Color white = const Color(0xffffffff);
  // Color backgroundColor = const Color(0xffffffff);
  // Color backgroundLowContrast = const Color(0xffe6e9eb);
  // Color cardColor = const Color(0xffffffff);
  // Color buttonColor = const Color(0xff121212);
  // Color buttonTextColor = const Color(0xffffffff);
  // Color defaultGrey = const Color(0xfff0f0f0);
  // Color borderGrey = const Color(0xffe3e3e3);
  // Color textGrey = const Color(0xff888888);
  // Color textColor = const Color(0xff121212);
  // Color highlightColor = const Color(0xfffb8c3b);
  // // Color black = const Color(0xff);


  Color white = const Color(0xffffffff);
  Color black = const Color(0xff292526);
  Color backgroundColor = const Color(0xfff7f8f8);
  Color backgroundLowContrast = const Color(0xffdee0e1);
  Color cardColor = const Color(0xfffafafa);
  Color buttonColor = const Color(0xff292526);
  Color buttonTextColor = const Color(0xffffffff);
  Color defaultGrey = const Color(0xffeaebeb);
  Color borderGrey = const Color(0xffeaebeb);
  Color textGrey = const Color(0xff969999);
  Color textColor = const Color(0xff292526);
  Color highlightColor = const Color(0xfffb8c3b);

  void setTheme(SysAppThemes theme){
    switch(theme){
      case SysAppThemes.light:
        black = const Color(0xff292526);
        white = const Color(0xffffffff);
        backgroundColor = const Color(0xffffffff);
        backgroundLowContrast = const Color(0xffdee0e1);
        cardColor = const Color(0xfffafafa);
        buttonColor = const Color(0xff292526);
        buttonTextColor = const Color(0xffffffff);
        defaultGrey = const Color(0xffeaebeb);
        borderGrey = const Color(0xffeaebeb);
        textGrey = const Color(0xff969999);
        textColor = const Color(0xff292526);
        highlightColor = const Color(0xfffb8c3b);
        break;
      case SysAppThemes.lightHC:
        black = const Color(0xff121212);
        white = const Color(0xffffffff);
        backgroundColor = const Color(0xffffffff);
        backgroundLowContrast = const Color(0xffe6e9eb);
        cardColor = const Color(0xffffffff);
        buttonColor = const Color(0xff121212);
        buttonTextColor = const Color(0xffffffff);
        defaultGrey = const Color(0xfff0f0f0);
        borderGrey = const Color(0xffe3e3e3);
        textGrey = const Color(0xff888888);
        textColor = const Color(0xff121212);
        highlightColor = Colors.lightBlueAccent;
        break;
      case SysAppThemes.dark:
        break;
      default:
        break;
    }
  }

  double borderRadiusForCard = 20;
  double borderRadiusForButton = 2000;

  double fontSizeBannerHeading = 30;
  double fontSizeBannerBody = 14;
  double fontSizeDefaultHeading = 30;
  double fontSizeDefaultBody = 30;
  double fontSizePageTitle = 30;
  double fontSizeTabBar = 30;
  double fontSizeBottomNav = 30;

  FontWeight fontWeightBannerHeading = FontWeight.w600;
  FontWeight fontWeightDefaultHeading = FontWeight.w500;
  FontWeight fontWeightDefaultBody = FontWeight.w400;

  TextStyle textStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    TextOverflow? overflow,
  }){
    return TextStyle(
      color: color ?? textColor,
      fontSize: fontSize ?? fontSizeDefaultBody,
      fontWeight: fontWeight ?? fontWeightDefaultBody,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      overflow: overflow,
    );
  }
}