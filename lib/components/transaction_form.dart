import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text.trim();
    final value = double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        top: 10,
        bottom: 10 + mediaQuery.viewInsets.bottom,
      ),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                submitForm: (_) => _submitForm(),
                controller: _titleController,
                keyboardtype: TextInputType.text,
              ),
              SizedBox(height: 10),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                submitForm: (_) => _submitForm(),
                controller: _valueController,
                keyboardtype: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 10),
              AdaptativeDatePicker(
                onDateChanged: (newDate) {
                  setState(() => _selectedDate = newDate);
                },
                selectedDate: _selectedDate,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
