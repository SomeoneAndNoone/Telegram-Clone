import 'package:flutter/material.dart';

import '../app_sizes.dart';
import '../common_colors.dart';

class CustomInput extends StatelessWidget {
  CustomInput({
    @required this.hint,
    @required this.label,
    @required this.isEnabled,
    @required this.onTextChanged,
  });

  final String hint;
  final String label;
  final bool isEnabled;
  final Function(String newText) onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.padding10),
          TextField(
            onChanged: onTextChanged,
            decoration: InputDecoration(
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
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: AppSizes.padding10, vertical: AppSizes.padding5),
              enabled: isEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
