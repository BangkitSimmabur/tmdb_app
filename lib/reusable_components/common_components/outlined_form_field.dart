import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';

class OutlinedFormField extends StatefulWidget {
  final TextEditingController inputController;
  final String? hintText;
  final TextInputType? inputType;
  final bool obscureText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final BorderSide? borderSide;
  final Function(String)? onChange;
  final bool? disabled;
  final double? fontSize;
  final Color? labelColor;
  final Color? focussedColor;

  const OutlinedFormField({
    super.key,
    required this.inputController,
    this.obscureText = false,
    this.prefixIcon,
    this.borderSide,
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
            color: widget.disabled! ? Constant.colorGreyText : Constant.colorWhite,
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
