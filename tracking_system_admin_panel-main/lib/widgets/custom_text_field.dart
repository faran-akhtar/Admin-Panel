import 'package:flutter/material.dart';
import 'widget_export.dart';
import '../styles/styles.dart';

// ignore: must_be_immutable
class TextInputField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final bool readOnly;
  TextInputType? textInputType;
  String? hint;
  final TextEditingController controller;
  final Color borderColor;
  final Color labelTextColor;
  final Color fillColor;
  void Function(String)? onChanged;
  String? Function(String?)? validator;

  TextInputField(
      {super.key,
      required this.label,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.borderColor = CustomColors.textFieldBorderColor,
      this.labelTextColor = CustomColors.whiteColor,
      this.fillColor = CustomColors.offWhiteColor,
      this.validator,
      this.readOnly = false,
      this.onChanged,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldsLabelWidget(
          label: label,
          hint: hint,
          textColor: labelTextColor,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: textInputType,
          validator: validator,
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.s4),
              borderSide: const BorderSide(
                color: CustomColors.redColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.s4),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.s4),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
