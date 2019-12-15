
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

    final List<Transaction> transactions;

    TransactionList(this.transactions);

    @override
    Widget build(BuildContext content) {
        return Container(
            height: 435,
            child: ListView(
                children: transactions.map((tx) {
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
                                            color: Colors.purple,
                                            width: 2,
                                        )
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        'AED ${tx.amount}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.purple
                                        ),
                                    ),
                                ),
                                Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                            tx.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 16
                                            )
                                        ),
                                        Text(
                                            // DateFormat('MM/dd/yyyy HH:mm').format(tx.date),
                                            DateFormat.yMMMd().format(tx.date),
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
                }).toList(),
            )
        );
    }
}
