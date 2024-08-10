import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:tmdb_app/helpers/constant.dart';

/// A custom reusable button with full slid background
class CustomButtonFullBordered extends StatelessWidget {
  /// The text displayed inside button
  final String labelText;

  /// The button's text color
  final Color? labelColor;

  /// The button's text size default to 16px
  final double labelSize;

  /// The button's background color default to white
  final Color? buttonColor;

  /// The button's action when pressed
  final VoidCallback? onClick;

  /// The button's border radius default to 12px
  final double borderRadius;

  /// The button's width default to taking the width of parent's widget width
  final double width;

  /// The button's text padding vertically inside button default to 8px
  final double padding;

  /// The button's status
  final bool active;

  /// The text maxLines inside button default to 1 line
  final int maxLines;

  /// The button's height
  final double height;

  /// The button's label font weight
  final FontWeight labelWeight;

  /// The button's label text overflow
  final TextOverflow textOverflow;

  const CustomButtonFullBordered(
    this.labelText, {
    super.key,
    this.buttonColor = Constant.colorWhite,
    this.labelColor,
    this.labelSize = Constant.fontSizeSM,
    this.onClick,
    this.borderRadius = Constant.borderRadiusMD,
    this.width = double.maxFinite,
    this.padding = Constant.paddingXXS,
    this.active = false,
    this.labelWeight = FontWeight.w600,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        key: key,
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            )),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: padding,
          ),
          child: Text(
            labelText,
            overflow: textOverflow,
            maxLines: maxLines,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: labelWeight,
              fontSize: labelSize,
              color: labelColor,
            ),
          ),
        ),
      ),
    );
  }
}
