import 'package:flutter/material.dart';
import '../styles/styles.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.childWidget,
    this.width,
    this.height,
    this.icon,
    this.labelStyle,
    this.borderRadius = 4.0,
    this.elevation = 0.0,
    this.letterSpacing = 0.0,
    this.backgroundColor = CustomColors.whiteColorShade,
  }) : super(key: key);

  final String label;
  final Widget? childWidget;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double? width;
  final Widget? icon;
  final TextStyle? labelStyle;
  final double? height;
  final double borderRadius;
  final double? elevation;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            backgroundColor,
          ),
          elevation: MaterialStateProperty.all(
            elevation,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            icon != null
                ? const SizedBox(
                    width: Sizes.s8,
                  )
                : const SizedBox.shrink(),
            childWidget ??
                Text(
                  label,
                  style: labelStyle ?? Theme.of(context).textTheme.button,
                ),
          ],
        ),
      ),
    );
  }
}
