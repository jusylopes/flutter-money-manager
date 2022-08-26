import 'package:expenses/models/enum/transaction_type.dart';
import 'package:expenses/models/transaction_model.dart';
import 'package:expenses/views/components/transaction_empty.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Transaction>(context);
    final List<TransactionModel> transactionList = provider.transactions;

    return transactionList.isEmpty
        ? const TransictionEmpty()
        : ListView.separated(
            itemCount: transactionList.length,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey,
                thickness: 0.8,
              );
            },
            itemBuilder: (ctx, index) {
              final transaction = transactionList[index];
              return Dismissible(
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  return await confirmDismissDialog(context);
                },
                key: Key(transaction.id),
                onDismissed: (_) {
                  Provider.of<Transaction>(context, listen: false)
                      .removeTransaction(transaction.id);
                },
                background: Container(
                  color: Colors.red[300],
                  child: const Center(
                    child: Text(
                      'Excluir transação',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                child: ListTile(
                  leading: transaction.type == TransactionType.income
                      ? Icon(
                          Icons.attach_money,
                          color: Colors.green[300],
                          size: 35,
                        )
                      : Icon(
                          Icons.money_off,
                          color: Colors.red[200],
                          size: 35,
                        ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      DateFormat('d MMM y').format(transaction.date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  trailing: Text(
                    '${transaction.type == TransactionType.expense ? '-' : ''} R\$ ${transaction.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: transaction.type == TransactionType.income
                          ? Colors.green[300]
                          : null,
                    ),
                   
                  ),
                ),
              );
            },
          );
  }
}

Future<bool?> confirmDismissDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirmar"),
        content: const Text("Tem certeza de que deseja excluir esta transação?"),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("EXCLUIR")),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCELAR"),
          ),
        ],
      );
    },
  );
}
