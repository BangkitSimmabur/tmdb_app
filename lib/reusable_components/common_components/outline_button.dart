import "package:flutter/material.dart";
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? labelText;
  final Color? labelColor;
  final Color? borderColor;
  final double labelSize;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final double borderRadius;
  final double width;
  final double padding;
  final bool active;
  final int maxLines;
  final double height;
  final FontWeight labelWeight;
  final TextOverflow textOverflow;
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
