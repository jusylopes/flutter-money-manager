import 'package:expenses/models/enum/transaction_type.dart';
import 'package:expenses/models/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class Transaction with ChangeNotifier {
  final List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => [..._transactions];

  double get totalBalance {
    double totalIncome = 0;
    double totalBalance = 0;
    double totalExpense = 0;

    for (var element in _transactions) {
      if (element.type == TransactionType.expense) {
        totalExpense += element.value;
      } else if (element.type == TransactionType.income) {
        totalIncome += element.value;
      }
    }
    totalBalance = totalIncome - totalExpense;

    return totalBalance;
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(String transactionId) {
    _transactions.removeWhere((transaction) => transaction.id == transactionId);
    notifyListeners();
  }
}
