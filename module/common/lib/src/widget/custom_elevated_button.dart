import 'package:flutter/material.dart';

/// [CustomElevatedButton] is custom elevated button
final class CustomElevatedButton extends StatelessWidget {
  /// Constructor
  const CustomElevatedButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.height = 50,
    this.width = double.infinity,
  });

  /// A callback function to handle the button press event.
  final VoidCallback? onPressed;

  /// The widget to display inside the button.
  final Widget? child;

  /// The height of the button.
  final double height;

  /// The width of the button.
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: child,
      ),
    );
  }
}
