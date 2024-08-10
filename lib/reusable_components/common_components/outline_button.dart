import "package:flutter/material.dart";
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';

/// A custom reusable button with outline border styling
class CustomOutlinedButton extends StatelessWidget {
  /// The text displayed inside button
  final String? labelText;

  /// The button's text and icon color
  final Color? labelColor;

  /// The button's text size default to 16px
  final double labelSize;

  /// The button's background color default to white
  final Color? buttonColor;

  /// The button's action when pressed
  final VoidCallback? onTap;

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

  /// The button's border color
  final Color? borderColor;

  /// The button's border radius default to 8px
  final double borderRadius;

  /// The button's icon displayed beside text or only icon to be displayed
  final IconData? icon;

  const CustomOutlinedButton({
    super.key,
    this.labelText,
    this.buttonColor = Constant.colorWhite,
    this.labelColor = Constant.colorBlack,
    this.labelSize = 16,
    this.onTap,
    this.borderRadius = Constant.borderRadiusSM,
    this.width = double.maxFinite,
    this.padding = Constant.paddingXS,
    this.active = false,
    this.labelWeight = FontWeight.w600,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.height = 4,
    this.borderColor = Constant.colorBlack,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: active ? Colors.white : buttonColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor ?? Colors.transparent)),
    );

    Widget childElement = Container(
      padding: EdgeInsets.only(
        top: padding,
        bottom: padding,
      ),
      child: icon != null && labelText == null
          ? Icon(
              icon,
              color: labelColor,
            )
          : CommonText(
              labelText ?? "",
              overflow: textOverflow,
              maxLines: maxLines,
              textAlign: TextAlign.center,
              fontWeight: labelWeight,
              fontSize: labelSize,
              textColor: labelColor,
            ),
    );

    return SizedBox(
      width: width,
      child: icon != null && labelText != null
          ? ElevatedButton.icon(
              icon: Icon(
                icon,
                color: labelColor,
              ),
              onPressed: onTap,
              style: buttonStyle,
              label: childElement,
            )
          : ElevatedButton(
              onPressed: onTap,
              style: buttonStyle,
              child: childElement,
            ),
    );
  }
}
