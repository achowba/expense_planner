import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    // set device orientation
    /* SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]); */
    runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

    final List<Transaction> _userTransactions = [
        Transaction(id: 't1', title: 'Icon X', amount: 500, date: DateTime.now()),
        Transaction(id: 't2', title: 'Nike Slides', amount: 110, date: DateTime.now()),
        Transaction(id: 't3', title: 'Shoes', amount: 340, date: DateTime.now()),
        Transaction(id: 't4', title: 'Watch Strap', amount: 40, date: DateTime.now()),
        Transaction(id: 't5', title: 'Headphones', amount: 540, date: DateTime.now()),
        Transaction(id: 't6', title: 'Hoodies', amount: 140, date: DateTime.now()),
        Transaction(id: 't7', title: 'Sweatpants', amount: 90, date: DateTime.now()),
    ];

    bool _showChart = false;

    @override
    void initState() {
        WidgetsBinding.instance.addObserver(this); // add an event listener that checks for changes in the app lifecycle
        super.initState();
    }

    @override
    didChangeAppLifecycleState(AppLifecycleState state) {
        print(state);
    }

    @override
    dispose() {
        WidgetsBinding.instance.removeObserver(this);
        super.dispose();
    }

    List<Transaction> get _recentTransactions {
        return _userTransactions.where((tx) {
            return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
        }).toList();
    }

    void _addNewTransaction (String txTitle, double txAmount, DateTime chosenDate) {
        final newTX = Transaction(
            title: txTitle,
            amount: txAmount,
            date: chosenDate,
            id: DateTime.now().toString()
        );

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

    void _deleteTransactions (String id) {
        setState(() {
            _userTransactions.removeWhere((tx) {
                return tx.id == id;
            });
        });
    }

    List <Widget> _buildLandscapeContent (MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
        return [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.title,
                    ),
                    Switch.adaptive(
                        activeColor: Theme.of(context).accentColor,
                        value: _showChart,
                        onChanged: (val) {
                            setState(() {
                                _showChart = val;
                            });
                        },
                    )
                ],
            ), _showChart ? Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: Chart(_recentTransactions),
            )
            : txListWidget
        ];
    }

    List<Widget> _buildPotraitContent (MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
        return [Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
            child: Chart(_recentTransactions),
        ), txListWidget];
    }

    PreferredSizeWidget _buildAppBar() {
        return Platform.isIOS
            ? CupertinoNavigationBar(
                middle: Text('Expense Planner'),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        GestureDetector(
                            child: Icon(CupertinoIcons.add),
                            onTap: () => _startAddNewTransaction(context),
                        )
                    ],
                ),
            )
            : AppBar(
                title: Text('Expense Planner'),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () => _startAddNewTransaction(context),
                        tooltip: 'Add New Transaction',
                    )
                ],
            );
    }

    @override
    Widget build(BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final isLandscape = mediaQuery.orientation == Orientation.landscape;
        final PreferredSizeWidget appBar = _buildAppBar();
        final txListWidget = Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
            child: TransactionList(_userTransactions, _deleteTransactions),
        );
        final pageBody = SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        if (isLandscape) ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
                        if (!isLandscape) ..._buildPotraitContent(mediaQuery, appBar, txListWidget),
                    ],
                ),
            )
        );

        return Platform.isIOS
            ? CupertinoPageScaffold(
                child: pageBody,
                navigationBar: appBar,
            )
            : Scaffold(
                appBar: appBar,
                body: pageBody,
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                ),
            );
    }
}
