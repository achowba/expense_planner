import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

    // create a variable to pass as a constructor which will be used as a ref to the addNexTransaction function
    final Function addNewTxHandler;

    NewTransaction(this.addNewTxHandler);

    @override
    _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    void _submitData () {
        final enteredTitle = titleController.text;
        final enteredAmount = double.parse(amountController.text);

        if (enteredTitle.isEmpty || enteredAmount <= 0) {
            return;
        }

        // use the widget property to access to the properties of connected widgets in another class
        widget.addNewTxHandler(enteredTitle, enteredAmount);
        Navigator.of(context).pop();
    }

    @override
    Widget build(BuildContext context) {
        return Card(
            elevation: 5,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                        TextField(
                            decoration: InputDecoration(
                                labelText: 'Title',
                            ),
                            controller: titleController,
                            onSubmitted: (_) => _submitData(), // the _ indicates the argument is not used in the function body
                        ),
                        TextField(
                            decoration: InputDecoration(
                                labelText: 'Amount',
                            ),
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            onSubmitted: (_) => _submitData(), // the _ indicates the argument is not used in the function body
                        ),
                        Container(
                            height: 70,
                            child: Row(
                                children: <Widget>[
                                    Text('No Date Chosen!'),
                                    FlatButton(
                                        textColor: Theme.of(context).primaryColor,
                                        child: Text(
                                            'Choose Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                        ),
                                        onPressed: () {},
                                    )
                                ],
                            ),
                        ),
                        RaisedButton(
                            child: Text('Add Transaction'),
                            textColor: Theme.of(context).textTheme.button.color,
                            color: Theme.of(context).primaryColor,
                            onPressed: _submitData,
                        ),
                    ],
                ),
            ),
        );
    }
}
