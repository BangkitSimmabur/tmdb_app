import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CommonText(
    this.text, {
    super.key,
    this.fontSize = Constant.fontSizeSM,
    this.textColor = Constant.colorBlack,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          overflow: overflow,
        ),
        textAlign: textAlign,
      );
}
