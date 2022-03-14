import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    Key? key,
    String? hintText,
    bool isRequired = false,
    Widget? suffixIcon,
    TextEditingController? textEditingController,
  })  : _hintText = hintText,
        _textEditingController = textEditingController,
        _suffixIcon = suffixIcon,
        _isRequired = isRequired,
        super(key: key);

  final bool _isRequired;
  final String? _hintText;
  final Widget? _suffixIcon;
  final TextEditingController? _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
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
