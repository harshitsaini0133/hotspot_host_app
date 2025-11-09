import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';

class CustomFormField extends StatelessWidget {
  final String? value;
  final String? hintText;
  final int maxLines;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const CustomFormField({
    super.key,
    this.controller,
    this.value,
    this.hintText,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 16,
        color: AppColorPallete.text1,
        fontWeight: FontWeight.w400,
      ),
      autocorrect: true,
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.white,
      initialValue: value,
    );
  }
}
