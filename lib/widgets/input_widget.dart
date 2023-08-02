import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final bool isValid;
  final String? initialValue;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChange;
  final bool isDisabled;
  final int? maxLines;

  const InputWidget({
    Key? key,
    this.isValid = true,
    this.initialValue,
    this.labelText = '',
    this.hintText = '',
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.validator,
    required this.onSaved,
    this.onChange,
    this.isDisabled = false,
    this.maxLines,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    if (widget.isDisabled) {
      _controller.text = widget.initialValue!;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
      _controller.addListener(() {
        if (_controller.text != widget.initialValue) {
          _controller.text = widget.initialValue ?? '';
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange(String value) {
    if (widget.onChange != null) {
      widget.onChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      maxLines: widget.maxLines,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF09101D)),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF09101D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            width: 1.0,
            color: Color(0xFF858C94),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            width: 1.0,
            color: Color(0xFF858C94),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFF858C94),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFF858C94),
          ),
        ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
      ),
      keyboardType: widget.textInputType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: _handleChange,
      obscureText: widget.obscureText,
      enabled: !widget.isDisabled,
      autovalidateMode:
          widget.isValid ? AutovalidateMode.disabled : AutovalidateMode.always,
      // Tắt tính năng tự động kiểm tra tính hợp lệ nếu isValid là true
    );
  }
}
