import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/helpers/constant.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String labelText;
  final Color? labelColor;
  final Color? borderColor;
  final double labelSize;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool isLoading;
  final double width;
  final double padding;
  final bool active;
  final int maxLines;
  final double height;
  final FontWeight labelWeight;
  final TextOverflow textOverflow;

  const CustomOutlinedButton(
    this.labelText, {
    super.key,
    this.buttonColor = Constant.white,
    this.labelColor = Constant.black,
    this.labelSize = 16,
    this.onTap,
    this.borderRadius = Constant.borderRadiusSM,
    this.isLoading = false,
    this.width = double.maxFinite,
    this.padding = Constant.paddingXS,
    this.active = false,
    this.labelWeight = FontWeight.w600,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.height = 4,
    this.borderColor = Constant.black,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomOutlinedButtonState();
  }
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ElevatedButton(
        key: widget.key,
        onPressed: !widget.isLoading ? widget.onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.active ? Colors.white : widget.buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side:
                  BorderSide(color: widget.borderColor ?? Colors.transparent)),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: widget.padding,
            bottom: widget.padding,
          ),
          child: widget.isLoading
              ? SpinKitThreeBounce(
                  color: widget.labelColor,
                  size: widget.labelSize,
                )
              : Text(
                  widget.labelText,
                  overflow: widget.textOverflow,
                  maxLines: widget.maxLines,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: widget.labelWeight,
                    fontSize: widget.labelSize,
                    color: widget.labelColor,
                  ),
                ),
        ),
      ),
    );
  }
}
