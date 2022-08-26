import 'package:expenses/models/enum/transaction_type.dart';
import 'package:expenses/models/transaction_model.dart';
import 'package:expenses/providers/transaction.dart';
import 'package:test/test.dart';

void main() {
  group('Testing App Provider |  ', () {
    final transaction = Transaction();
    final transactionTest1 = TransactionModel(
        id: '',
        title: '',
        type: TransactionType.expense,
        value: 200,
        date: DateTime.now());

    final TransactionModel transactionTest2 = TransactionModel(
        id: '',
        title: '',
        type: TransactionType.income,
        value: 600,
        date: DateTime.now());

    const double numberBalance = 400;

    test('A new transaction should be added', () {
      transaction.addTransaction(transactionTest1);
      expect(transaction.transactions.contains(transactionTest1), true);
    });

    test('An transaction should be removed', () {      
      transaction.removeTransaction(transactionTest1.id);
      expect(transaction.transactions.contains(transactionTest1), false);
    });

    test('Transaction balance should return $numberBalance', () {
      transaction.addTransaction(transactionTest1);
      transaction.addTransaction(transactionTest2);
      expect(transaction.totalBalance, equals(numberBalance));
    });
  });
}
