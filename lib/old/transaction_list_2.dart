import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

    final List<Transaction> transactions;

    TransactionList(this.transactions);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 435,
            child: transactions.isEmpty ? Column(
                children: <Widget>[
                    Text(
                        'No Transactions Added Yet',
                        style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                        height: 30,
                    ),
                    Container(
                        height: 200,
                        child: Image.asset(
                            'assets/img/waiting.png',
                            fit: BoxFit.cover,
                        ),
                    )
                ],
            )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                    return Card(
                        child: Row(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context).primaryColorDark,
                                            width: 2,
                                        )
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        '${transactions[index].amount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Theme.of(context).primaryColor
                                        ),
                                    ),
                                ),
                                Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                            transactions[index].title,
                                            style: Theme.of(context).textTheme.title,
                                        ),
                                        Text(
                                            // DateFormat('MM/dd/yyyy HH:mm').format(tx.date),
                                            DateFormat.yMMMd().format(transactions[index].date),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey
                                            ),
                                        ),
                                    ],
                                )
                            ],
                        ),
                    );
                },
                itemCount: transactions.length,
            )
        );
    }
}
