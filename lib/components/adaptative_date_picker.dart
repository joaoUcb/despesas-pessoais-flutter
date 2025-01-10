import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({
    required this.selectedDate,
    required this.onDateChanged,
  });

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (Platform.isIOS) {
      // iOS
      return SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: selectedDate,
          minimumDate: DateTime(2019),
          maximumDate: DateTime.now(),
          onDateTimeChanged: onDateChanged,
        ),
      );
    } else {
      return SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate == null
                    ? 'Nenhuma Data Selecionada'
                    : DateFormat('dd/MM/y').format(selectedDate),
                style: theme.textTheme.bodyLarge,
              ),
            ),
            TextButton(
              onPressed: () => _showDatePicker(context),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('Selecionar Data'),
            ),
          ],
        ),
      );
    }
  }
}
