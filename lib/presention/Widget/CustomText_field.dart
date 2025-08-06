import 'package:flutter/material.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.maxLines = 1,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  final String label;
  final String? hintText;
  final int maxLines;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty) ...[
            Text(
              widget.label,
              style: TextStyle(
                color: _isFocused
                  ? ColorPalette.primary
                  : ColorPalette.getTextColor(isDarkMode),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            validator: widget.validator ?? (value) {
              if (value?.isEmpty ?? true) {
                return 'Field is required';
              }
              return null;
            },
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            cursorColor: ColorPalette.primary,
            style: TextStyle(
              color: ColorPalette.getTextColor(isDarkMode),
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: ColorPalette.getTextColor(isDarkMode, isSecondary: true),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: _isFocused
                  ? ColorPalette.primary.withOpacity(0.1)
                  : ColorPalette.getSurfaceColor(isDarkMode),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _isFocused
                      ? ColorPalette.primary
                      : ColorPalette.getTextColor(isDarkMode, isSecondary: true).withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: ColorPalette.getTextColor(isDarkMode, isSecondary: true).withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ColorPalette.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ColorPalette.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ColorPalette.error,
                  width: 2,
                ),
              ),
              errorStyle: TextStyle(
                color: ColorPalette.error,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
