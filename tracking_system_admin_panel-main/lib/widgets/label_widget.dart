import 'package:flutter/material.dart';
import '../styles/styles.dart';

class FieldsLabelWidget extends StatelessWidget {
  const FieldsLabelWidget({
    super.key,
    required this.label,
    this.hint,
    this.textColor = CustomColors.whiteColor,
  });

  final String label;
  final String? hint;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          hint != null && hint != ''
              ? Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    hint!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: CustomColors.offWhiteColor,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
