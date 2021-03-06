import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {

    final List<Transaction> transactions;
    final Function deleteTxHandler;

    TransactionList(this.transactions, this.deleteTxHandler);

    @override
    Widget build(BuildContext context) {
        return transactions.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                    return Column(
                        children: <Widget>[
                            Text(
                                'No Transactions Added Yet',
                                style: Theme.of(context).textTheme.title,
                            ),
                            SizedBox(
                                height: 30,
                            ),
                            Container(
                                height: constraints.maxHeight * 0.6,
                                child: Image.asset(
                                    'assets/img/waiting.png',
                                    fit: BoxFit.cover,
                                ),
                            )
                        ],
                    );
                }
            )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                    return TransactionItem(transaction: transactions[index], deleteTxHandler: deleteTxHandler);
                },
                itemCount: transactions.length,
            );
    }
}
