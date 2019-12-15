import 'package:flutter/material.dart';

import './../widgets/new_transaction.dart';
import './../models/transaction.dart';

class UserTransactions extends StatefulWidget {
    @override
    _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransactions> {

    final List<Transaction> _userTransactions = [
        Transaction(id: 't1', title: 'Icon X', amount: 500, date: DateTime.now()),
        Transaction(id: 't2', title: 'Nike Slides', amount: 110, date: DateTime.now())
    ];

    void _addNewTransaction (String txTitle, double txAmount) {
        final newTX = Transaction(title: txTitle, amount: txAmount, date: DateTime.now(), id: DateTime.now().toString());

        setState(() {
            _userTransactions.add(newTX);
        });
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                NewTransaction(_addNewTransaction),
                // TransactionList(_userTransactions)
            ],
        );
    }
}
