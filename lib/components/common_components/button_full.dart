import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/helpers/constant.dart';

class CustomButtonFullBordered extends StatefulWidget {
  final String labelText;
  final Color? labelColor;
  final double labelSize;
  final Color? buttonColor;
  final VoidCallback? onClick;
  final double borderRadius;
  final bool isLoading;
  final double width;
  final double padding;
  final bool active;
  final int maxLines;
  final double height;
  final BorderSide? btnBorderSide;
  // Border btnBorder;
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
    this.isLoading = false,
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
  State<StatefulWidget> createState() {
    return _CustomButtonFullBorderedState();
  }
}

class _CustomButtonFullBorderedState extends State<CustomButtonFullBordered> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ElevatedButton(
        key: widget.key,
        onPressed: !widget.isLoading ? widget.onClick : null,
        style: ElevatedButton.styleFrom(
            backgroundColor:
                widget.active ? Constant.white : widget.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            )),
        child: Container(
          padding: EdgeInsets.only(
            top: widget.padding,
            bottom: widget.padding,
          ),
          child: widget.isLoading
              ? Stack(
                  children: <Widget>[
                    SpinKitThreeBounce(
                      color: widget.labelColor,
                      size: widget.labelSize,
                    ),
                    Text(
                      "",
                      style: TextStyle(
                        fontWeight: widget.labelWeight,
                        fontSize: widget.labelSize,
                        color: widget.labelColor,
                      ),
                    )
                  ],
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
