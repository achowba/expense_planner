import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
    const TransactionItem({
        Key key,
        @required this.transaction,
        @required this.deleteTxHandler,
    }) : super(key: key);

    final Transaction transaction;
    final Function deleteTxHandler;

    @override
    _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

    Color _bgColor;

    @override
    void initState() {
        const availableColors = [
            Colors.red,
            Colors.black,
            Colors.blue,
            Colors.yellow,
            Colors.green,
            Colors.pink,
            Colors.red,
            Colors.blueGrey,
            Colors.greenAccent,
            Colors.purple
        ];

        _bgColor = availableColors[Random().nextInt(availableColors.length + 1)];
        super.initState();
    }

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
                    backgroundColor: _bgColor,
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                '\$${widget.transaction.amount}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                            ),
                        ),
                    ),
                ),
                title: Text(
                    widget.transaction.title,
                    style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                    DateFormat.yMMMd().format(widget.transaction.date),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    icon: const Icon(Icons.delete), // use const to indicate that the widget is immutable
                    label: const Text('Delete'),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () => widget.deleteTxHandler(widget.transaction.id),
                )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => widget.deleteTxHandler(widget.transaction.id),
                ),
            ),
        );
    }
}
