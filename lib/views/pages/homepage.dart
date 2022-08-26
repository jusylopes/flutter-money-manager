import 'package:expenses/providers/transaction.dart';
import 'package:expenses/views/components/transaction_form.dart';
import 'package:expenses/views/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _height;
  bool _totalBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Finance App',
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(50)),
            gradient: LinearGradient(
                colors: [Colors.pink, Theme.of(context).primaryColor],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_height * 0.15),
          child: Column(
            children: [
              const Text(
                'Saldo Total',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Consumer<Transaction>(
                  builder: ((context, transaction, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' R\$ ${_totalBalanceVisible ? transaction.totalBalance.toStringAsFixed(2) : '-----'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _totalBalanceVisible = !_totalBalanceVisible;
                              });
                            },
                            child: const Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 26,
                            ))
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: _height * 0.7,
                child: const TransactionList(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              elevation: 5,
              context: context,
              builder: (context) {
                return const TransactionForm();
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
