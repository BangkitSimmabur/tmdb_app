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
  static const Color blue = Color(0xff0000FF);
  static const Color darkBlue = Color(0xff032541);
  static const Color lightBlue = Color(0xff01b3e4);
  static const Color vibrantLightBlue = Color(0xff0074f1);
  static const Color vibrantDarkBlue = Color(0xff062541);
  static const Color grey = Color(0xff808080);
  static const Color lightGrey = Color(0xffe3e3e3);
  static const Color darkGrey = Color(0xffc8c8c8);
  static const Color darkRed = Color(0xffc61439);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color whiteOpacity25 = Color(0x40ffffff);
  static const Color whiteOpacity50 = Color(0x80ffffff);
  static const Color whiteOpacity75 = Color(0xBFffffff);
  static const Color blackOpacity25 = Color(0x40000000);
  static const Color blackOpacity50 = Color(0x80000000);
  static const Color blackOpacity75 = Color(0xBF000000);

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
  static double defaultPaddingView = 10.0;
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
  static const String apiKey = '5768f327d0eee19143087d1e23116d27';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  //tmd image path according to width
  static const String imagePath92 = "https://image.tmdb.org/t/p/w92";
  static const String imagePath154 = "https://image.tmdb.org/t/p/w154";
  static const String imagePath185 = "https://image.tmdb.org/t/p/w185";
  static const String imagePath342 = "https://image.tmdb.org/t/p/w342";
  static const String imagePath500 = "https://image.tmdb.org/t/p/w500";
  static const String imagePath780 = "https://image.tmdb.org/t/p/w780";
  static const String imagePathOriginal = "https://image.tmdb.org/t/p/original";
}
