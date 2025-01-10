import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final Function submitForm;
  final TextEditingController controller;
  final TextInputType keyboardtype;

  const AdaptativeTextField({
    required this.label,
    required this.submitForm,
    required this.controller,
    required this.keyboardtype,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CupertinoTextField(
          controller: controller,
          onSubmitted: (_) => submitForm(),
          keyboardType: keyboardtype,
          placeholder: label,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CupertinoColors.systemGrey4,
              width: 1.0,
            ),
          ),
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
      );
    } else {
      return TextField(
        controller: controller,
        onSubmitted: (_) => submitForm(),
        keyboardType: keyboardtype,
        decoration: InputDecoration(
          labelText: label,
        ),
        style: theme.textTheme.bodyLarge,
      );
    }
  }
}
