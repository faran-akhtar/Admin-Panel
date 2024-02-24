import 'package:flutter/material.dart';
import '../styles/styles.dart';

class DropDownUpdated extends StatelessWidget {
  final Widget? dropdownValue;
  final String? errorText;
  final List<String> dropdownList;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Key? dropdownKey;
  final double horizontal;
  final double vertical;

  const DropDownUpdated(
      {Key? key,
      required this.dropdownList,
      this.onChanged,
      this.dropdownValue,
      this.focusNode,
      this.errorText,
      this.horizontal = 20,
      this.vertical = 20,
      this.onTap,
      this.dropdownKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return DropdownButtonFormField(
      key: dropdownKey,
      isExpanded: true,
      focusNode: focusNode,
      decoration: InputDecoration(
        fillColor: CustomColors.whiteColor,
        filled: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        errorText: errorText,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CustomColors.textFieldBorderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CustomColors.textFieldBorderColor,
            width: 1,
          ),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CustomColors.textFieldBorderColor,
            width: 1,
          ),
        ),
      ),
      hint: dropdownValue,
      dropdownColor: CustomColors.whiteColor,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: CustomColors.textFieldBorderColor,
      ),
      iconSize: 24,
      borderRadius: BorderRadius.circular(30),
      items: dropdownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: theme.labelLarge!.copyWith(color: Colors.black),
            ));
      }).toList(),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
