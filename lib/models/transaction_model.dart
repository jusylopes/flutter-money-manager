import 'package:expenses/models/enum/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionModel with ChangeNotifier {
  final String id;
  final String title;
  final TransactionType type;
  final double value;
  final DateTime date;

  TransactionModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.value,
      required this.date});
}
