import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';

/// A custom reusable App Bar with predefined attributes
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Appbar title required
  final String title;

  /// The font size of app bar title default to 30px
  final double? fontSize;

  /// The title and icons color default to app color white
  final Color? textColor;

  /// The title font weight default to bold
  final FontWeight? fontWeight;

  /// The action buttons on the right side of app bar
  final List<Widget>? actions;

  const CommonAppBar(
    this.title, {
    super.key,
    this.fontSize = Constant.fontSizeXL,
    this.textColor = Constant.colorWhite,
    this.fontWeight = FontWeight.bold,
    this.actions,
  }) : preferredSize = const Size.fromHeight(56.0);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constant.colorDarkestRed,
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
