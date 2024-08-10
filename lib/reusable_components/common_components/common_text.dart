import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';

/// A custom reusable text widget
class CommonText extends StatelessWidget {
  /// The text displayed
  final String text;

  /// The text font size default to 16px
  final double? fontSize;

  /// The text color default to black color
  final Color? textColor;

  /// The text font weight to be displayed
  final FontWeight? fontWeight;

  /// The alignment of the text horizontally. eg: ```TextAlign.start```
  final TextAlign? textAlign;

  /// The behaviour of the text if it's overflow form parent's widget. eg:```TextOverflow.ellipsis```
  final TextOverflow? overflow;

  /// The max lines of the text
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
