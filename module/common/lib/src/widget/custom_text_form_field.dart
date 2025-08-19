import 'package:common/src/decoration/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is for authentication text form field
final class CustomTextFormField extends StatefulWidget {
  /// Constructor
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.borderColor,
    this.activeBorderColor,
    this.deActiveBorderColor,
    this.errorBorderColor,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autocorrect = false,
    this.obscureText = false,
    this.enabled = true,
    this.obscuringCharacter = '•',
    this.suffixIcon,
    this.onClear,
    this.autoValidateMode,
  });

  /// The label text to display above the text field.
  final String? labelText;

  /// The hint text to display inside the text field when it is empty.
  final String? hintText;

  /// A function to validate the input text.
  final String? Function(String?)? validator;

  /// A callback function to handle the saved value of the text field.
  final void Function(String? value)? onSaved;

  /// A callback function to handle the submitted value of the text field.
  final void Function(String value)? onFieldSubmitted;

  /// A callback function to handle changes to the text field's value.
  final void Function(String value)? onChanged;

  /// A callback function to handle the clear action of the text field.
  final void Function()? onClear;

  /// A widget to display as a prefix icon inside the text field.
  final Widget? prefixIcon;

  /// A controller for the text field to manage its state.
  final TextEditingController? controller;

  /// A list of input formatters to apply to the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// The type of keyboard to use for the text field.
  final TextInputType? keyboardType;

  /// The action button to display on the keyboard.
  final TextInputAction? textInputAction;

  /// The color of the text field's border.
  final Color? borderColor;

  /// The color of the text field's border when it is active.
  final Color? activeBorderColor;

  /// The color of the text field's border when it is not active.
  final Color? deActiveBorderColor;

  /// The color of the text field's border when there is an error.
  final Color? errorBorderColor;

  /// Whether to enable autocorrect for the text field.
  final bool autocorrect;

  /// Whether to obscure the text being entered.
  final bool obscureText;

  /// Whether the text field is enabled.
  final bool enabled;

  /// The character to use for obscuring text.
  final String obscuringCharacter;

  /// A focus node to handle focus for the text field.
  final FocusNode? focusNode;

  /// An icon button to display as a suffix icon inside the text field.
  final IconButton? suffixIcon;

  /// The mode to use for auto validation.
  final AutovalidateMode? autoValidateMode;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autoValidateMode,
      onChanged: widget.onChanged,
      decoration: CustomInputDecoration(
        context: context,
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _SuffixIcon(
          controller: widget.controller,
          suffixIcon: widget.suffixIcon,
          onClear: widget.onClear,
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        borderColor:
            widget.borderColor ?? Theme.of(context).colorScheme.primary,
        enableBorderColor:
            widget.activeBorderColor ?? Theme.of(context).colorScheme.secondary,
        deActiveBorderColor: widget.deActiveBorderColor ??
            Theme.of(context).colorScheme.secondary,
        errorBorderColor:
            widget.errorBorderColor ?? Theme.of(context).colorScheme.error,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      autocorrect: widget.autocorrect,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      enabled: widget.enabled,
    );
  }
}

/// [_SuffixIcon] is a private class that is used to show the suffix icon in the text form field
final class _SuffixIcon extends StatefulWidget {
  const _SuffixIcon({
    required this.controller,
    this.suffixIcon,
    this.onClear,
  });

  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final VoidCallback? onClear;

  @override
  State<_SuffixIcon> createState() => _SuffixIconState();
}

class _SuffixIconState extends State<_SuffixIcon> {
  late bool _isClearButtonVisible;

  @override
  void initState() {
    super.initState();
    _isClearButtonVisible = widget.controller?.text.isNotEmpty ?? false;
    widget.controller?.addListener(_updateVisibility);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateVisibility);
    super.dispose();
  }

  void _updateVisibility() {
    setState(() {
      _isClearButtonVisible = widget.controller?.text.isNotEmpty ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isClearButtonVisible
        ? SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: Row(
              mainAxisAlignment: widget.suffixIcon != null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.suffixIcon ?? const SizedBox.shrink(),
                _SuffixClearIcon(
                  onTap: () {
                    widget.controller?.clear();
                    widget.onClear?.call();
                  },
                  isVisible: _isClearButtonVisible,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

/// [_SuffixClearIcon] is a private class that is used to show the suffix clear button
final class _SuffixClearIcon extends StatelessWidget {
  const _SuffixClearIcon({this.onTap, this.isVisible = false});

  final VoidCallback? onTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.clear_outlined),
          )
        : const SizedBox.shrink();
  }
}
