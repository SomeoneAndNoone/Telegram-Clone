import 'package:flutter/material.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/common_colors.dart';

class InputText extends StatelessWidget {
  InputText({
    Key key,
    @required this.hint,
    @required this.onTextChanged,
    @required this.errorText,
    this.isObscure = false,
  });

  final String hint;
  final String errorText;
  final bool isObscure;
  final Function(String newText) onTextChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 50,
      obscureText: isObscure,
      onChanged: (text) {
        onTextChanged(text);
        // _errorMsg = null/;
        // setState(() {});
      },
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryLight, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryLight, width: 1.0),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: AppSizes.padding10, vertical: AppSizes.padding5),
      ),
    );
  }
}
