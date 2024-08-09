import 'package:flutter/material.dart';

class Constant {
  //font Sizes
  static const double fontSizeXXS = 12.0;
  static const double fontSizeXS = 14.0;
  static const double fontSizeSM = 16.0;
  static const double fontSizeMD = 18.0;
  static const double fontSizeLG = 24.0;
  static const double fontSizeXL = 30.0;

  //Color
  static const Color colorGreyText = Color(0xff848484);
  static const Color colorGreyBorder = Color(0xffECECEC);
  static const Color colorLightGrey = Color(0xffe3e3e3);
  static const Color colorDarkGrey = Color(0xffc8c8c8);
  static const Color colorDarkRed = Color(0xffc61439);
  static const Color colorRed = Color(0xffff0000);
  static const Color colorBlack = Color(0xff000000);
  static const Color colorWhite = Color(0xffffffff);
  static const Color colorWhiteOpacity75 = Color(0xBFffffff);
  static const Color colorBlackOpacity25 = Color(0x40000000);
  static const Color colorBlackOpacity50 = Color(0x80000000);
  static const Color colorBlackOpacity75 = Color(0xBF000000);

  //spacing
  static const double spacingXXS = 4.0;
  static const double spacingXS = 8.0;
  static const double spacingSM = 16.0;
  static const double spacingMD = 24.0;
  static const double spacingLG = 32.0;
  static const double spacingXL = 40.0;

  //duration
  static const Map<String?, Duration?> defaultDurationSnackbar = {
    "duration": Duration(seconds: 5),
    "animationDuration": Duration(milliseconds: 200),
  };

  //padding
  static const double paddingXXS = 4.0;
  static const double paddingXS = 8.0;
  static const double paddingSM = 12.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 20.0;
  static const double paddingXL = 24.0;

  //border radius
  static const double borderRadiusXS = 4.0;
  static const double borderRadiusSM = 8.0;
  static const double borderRadiusMD = 12.0;
  static const double borderRadiusLG = 28.0;

  //tmdb api key
  static const String tmdbApiKey = '5768f327d0eee19143087d1e23116d27';
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbRegisterUrl = 'https://www.themoviedb.org/signup';

  //tmd image path according to width
  static const String imagePath92 = "https://image.tmdb.org/t/p/w92";
  static const String imagePath154 = "https://image.tmdb.org/t/p/w154";
  static const String imagePath185 = "https://image.tmdb.org/t/p/w185";
  static const String imagePath342 = "https://image.tmdb.org/t/p/w342";
  static const String imagePath500 = "https://image.tmdb.org/t/p/w500";
  static const String imagePath780 = "https://image.tmdb.org/t/p/w780";
  static const String imagePathOriginal = "https://image.tmdb.org/t/p/original";
}
