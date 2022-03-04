import 'package:flutter/material.dart';

import 'label_text_view.dart';

class InputFieldSectionView extends StatelessWidget {
  final String label;
  final bool isPasswordField;
  final TextInputType inputType;
  final TextEditingController controller;
  final String initialText;

  InputFieldSectionView(
      this.label, {
        this.isPasswordField = false,
        this.inputType = TextInputType.text,
        required this.controller,
        this.initialText = "",
      }) {
    controller.text = initialText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelTextView(label),
        TextField(
          obscureText: isPasswordField,
          keyboardType: inputType,
          controller: controller,
        ),
      ],
    );
  }
}