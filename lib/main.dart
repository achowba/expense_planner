import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Expense Planner',
            theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                accentColor: Colors.amber,
                fontFamily: 'QuickSand',
                // setting a global textStyle to be used my different Text widgets
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                    ),
                    button: TextStyle(
                        color: Colors.white,
                    ),
                ),
                appBarTheme: AppBarTheme(
                    textTheme: ThemeData.light().textTheme.copyWith(
                        title: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )
                    )
                )
            ),
            home: MyHomePage(),
            debugShowCheckedModeBanner: false,
        );
    }
}

class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    final List<Transaction> _userTransactions = [
        /* Transaction(id: 't1', title: 'Icon X', amount: 500, date: DateTime.now()),
        Transaction(id: 't2', title: 'Nike Slides', amount: 110, date: DateTime.now()) */
    ];

    List<Transaction> get _recentTransactions {
        return _userTransactions.where((tx) {
            return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
        }).toList();
    }

    void _addNewTransaction (String txTitle, double txAmount) {
        final newTX = Transaction(title: txTitle, amount: txAmount, date: DateTime.now(), id: DateTime.now().toString());

        setState(() {
            _userTransactions.add(newTX);
        });
    }

    void _startAddNewTransaction(BuildContext ctx) {
        // modalBottomSheet takes in a context as an argument and a builder which also takes another context as its argument
        showModalBottomSheet(
            context: ctx,
            builder: (_) {
                return GestureDetector(
                    onTap: () {},
                    child: NewTransaction(_addNewTransaction),
                    behavior: HitTestBehavior.opaque,
                );
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Expense Planner'),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () => _startAddNewTransaction(context),
                        tooltip: 'Add New Transaction',
                    )
                ],
            ),
            body: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        /* Container(
                            width: double.infinity,
                            child: Card(
                                color: Colors.green,
                                child: Text('Chart!'),
                                elevation: 5,
                            ),
                        ), */
                        Chart(_recentTransactions),
                        TransactionList(_userTransactions)
                    ],
                ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
            ),
        );
    }
}
