import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/type_helper.dart';

class OutlinedFormField extends StatefulWidget {
  final TextEditingController inputController;
  final String? hintText;
  final TextInputType? inputType;
  final bool obscureText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final BorderSide? borderSide;
  final OnChangeStr? onChange;
  final bool? disabled;
  final double? fontSize;

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
    this.fontSize,
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
        fontSize: widget.fontSize ?? Constant.fontSizeSM,
      ),
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Constant.greyText,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Constant.greyText,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.disabled! ? Constant.greyText : Constant.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Constant.greyText,),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixIconColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.error)
              ? Constant.darkRed
              : states.contains(MaterialState.focused) ||
                      widget.inputController.text != ""
                  ? widget.disabled!
                      ? Constant.greyText
                      : Constant.white
                  : Constant.greyText,
        ),
        suffixIconColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.error)
              ? Constant.darkRed
              : states.contains(MaterialState.focused) ||
                      widget.inputController.text != ""
                  ? widget.disabled!
                      ? Constant.greyText
                      : Constant.white
                  : Constant.greyText,
        ),
      ),
    );
  }
}
