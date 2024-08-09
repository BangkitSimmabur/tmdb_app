import 'package:flutter/material.dart';
import 'package:tmdb_app/components/common_components/common_text.dart';
import 'package:tmdb_app/helpers/constant.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final List<Widget>? actions;

  const CommonAppBar(
    this.title, {
    super.key,
    this.fontSize = Constant.fontSizeXL,
    this.textColor = Constant.white,
    this.fontWeight = FontWeight.bold,
    this.actions,
  }) : preferredSize = const Size.fromHeight(56.0);


  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constant.black,
      elevation: 0,
      title: CommonText(
        title,
        fontSize: fontSize,
        textColor: textColor,
        fontWeight: fontWeight,
      ),
      actions: actions,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: textColor, // <= You can change your color here.
      ),
    );
  }
}
