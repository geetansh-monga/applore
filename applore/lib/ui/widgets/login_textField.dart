import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key? key,
    String? hintText,
    bool readOnly = false,
    bool obscureText = false,
    bool isRequired = false,
    Widget? suffixIcon,
    TextEditingController? textEditingController,
  })  : _hintText = hintText,
        _textEditingController = textEditingController,
        _obscureText = obscureText,
        _suffixIcon = suffixIcon,
        _isRequired = isRequired,
        _readOnly = readOnly,
        super(key: key);

  final bool _readOnly;
  final bool _isRequired;
  final bool _obscureText;
  final String? _hintText;
  final Widget? _suffixIcon;
  final TextEditingController? _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: _readOnly,
      controller: _textEditingController,
      obscureText: _obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (_isRequired) if (value == null || value == "") return "required";
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: _suffixIcon,
        hintText: _hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
