import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';

/// A custom reusable text field with outline border and transparent background styling
class OutlinedFormField extends StatefulWidget {
  /// The text input controller
  final TextEditingController inputController;

  /// The text displayed inside text field as a hint
  final String? hintText;

  /// What type of keyboard used to type the text field
  final TextInputType? inputType;

  /// Whether the text is displayed or hidden
  final bool obscureText;

  /// Icon displayed at the left side of the text
  final Icon? prefixIcon;

  /// Icon displayed at the right side of the text
  final Widget? suffixIcon;

  /// Action when the keyboard is typing
  final Function(String)? onChange;

  /// Whether the text field can be typed or not
  final bool? disabled;

  /// The text size inside the text filed
  final double? fontSize;

  /// The color of the text inside the text field
  final Color? labelColor;

  /// The tex field color when the user is typing
  final Color? focussedColor;

  const OutlinedFormField({
    super.key,
    required this.inputController,
    this.obscureText = false,
    this.prefixIcon,
    this.onChange,
    this.hintText,
    this.inputType,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = Constant.fontSizeSM,
    this.labelColor = Constant.colorWhite,
    this.focussedColor = Constant.colorWhite,
  });
  @override
  State<OutlinedFormField> createState() => _OutlinedFormFieldState();
}

class _OutlinedFormFieldState extends State<OutlinedFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      readOnly: widget.disabled ?? false,
      obscureText: widget.obscureText,
      controller: widget.inputController,
      onChanged: widget.onChange,
      style: TextStyle(
        fontSize: widget.fontSize,
        color: widget.labelColor,
      ),
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Constant.colorGreyText,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Constant.colorGreyText,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.disabled! ? Constant.colorGreyText : Constant.colorWhite,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        focusColor: widget.focussedColor,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Constant.colorGreyText,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixIconColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.focused) ||
                  widget.inputController.text != ""
              ? widget.disabled!
                  ? Constant.colorGreyText
                  : Constant.colorWhite
              : Constant.colorGreyText,
        ),
        suffixIconColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.focused) ||
                  widget.inputController.text != ""
              ? widget.disabled!
                  ? Constant.colorGreyText
                  : Constant.colorWhite
              : Constant.colorGreyText,
        ),
      ),
    );
  }
}
