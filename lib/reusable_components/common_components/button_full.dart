import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:tmdb_app/helpers/constant.dart';

class CustomButtonFullBordered extends StatelessWidget {
  final String labelText;
  final Color? labelColor;
  final double labelSize;
  final Color? buttonColor;
  final VoidCallback? onClick;
  final double borderRadius;
  final double width;
  final double padding;
  final bool active;
  final int maxLines;
  final double height;
  final BorderSide? btnBorderSide;
  final FontWeight labelWeight;
  final TextOverflow textOverflow;

  const CustomButtonFullBordered(
    this.labelText, {
    super.key,
    this.buttonColor,
    this.labelColor,
    this.labelSize = 16,
    this.onClick,
    this.borderRadius = 10.0,
    this.width = double.maxFinite,
    this.padding = 8,
    this.active = false,
    this.labelWeight = FontWeight.w600,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.height = 4,
    this.btnBorderSide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        key: key,
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            backgroundColor: active ? Constant.colorWhite : buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            )),
        child: Container(
          padding: EdgeInsets.only(
            top: padding,
            bottom: padding,
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
