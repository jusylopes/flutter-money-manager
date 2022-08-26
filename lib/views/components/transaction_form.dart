import 'dart:math';

import 'package:expenses/models/enum/transaction_type.dart';
import 'package:expenses/models/transaction_model.dart';
import 'package:expenses/providers/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  bool _isExpense = true;

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final id = Random().nextDouble().toString();
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final type = _isExpense ? TransactionType.expense : TransactionType.income;

    if (title.isEmpty || value <= 0) {
      return;
    }

    Provider.of<Transaction>(context, listen: false).addTransaction(
        TransactionModel(
            id: id,
            title: title,
            type: type,
            value: value,
            date: _selectedDate));
   
    Navigator.of(context).pop();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'RECEITA',
                  style:
                      TextStyle(color: _isExpense ? null : Colors.green[300]),
                ),
                Switch.adaptive(
                  value: _isExpense,
                  activeColor: Colors.red[300],
                  inactiveThumbColor: Colors.green[300],
                  onChanged: (newValue) {
                    setState(() {
                      _isExpense = newValue;
                    });
                  },
                ),
                Text(
                  'DESPESA',
                  style: TextStyle(color: _isExpense ? Colors.red[300] : null),
                ),
              ],
            ),
            TextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Data: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
              TextButton(
                  onPressed: _showDatePicker,
                  child: const Text(
                    'Selecionar Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('adicionar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
