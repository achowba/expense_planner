import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
    const TransactionItem({
        Key key,
        @required this.transaction,
        @required this.deleteTxHandler,
    }) : super(key: key);

    final Transaction transaction;
    final Function deleteTxHandler;

    @override
    Widget build(BuildContext context) {
        return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
            ),
            child: ListTile(
                leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transaction.amount}'),
                        ),
                    ),
                ),
                title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                    DateFormat.yMMMd().format(transaction.date),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    icon: const Icon(Icons.delete), // use const to indicate that the widget is immutable
                    label: const Text('Delete'),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () => deleteTxHandler(transaction.id),
                )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTxHandler(transaction.id),
                ),
            ),
        );
    }
}
