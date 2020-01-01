import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_button.dart';

class NewTransaction extends StatefulWidget {

    // create a variable to pass as a constructor which will be used as a ref to the addNexTransaction function
    final Function addNewTxHandler;

    NewTransaction(this.addNewTxHandler) {
        // print('Constructor NewTransaction Widget');
    }

    @override
    _NewTransactionState createState() {
        // print('createState NewTransaction Widget');
        return _NewTransactionState();
    }
}

class _NewTransactionState extends State<NewTransaction> {
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    DateTime _selectedDate;

    _NewTransactionState() {
        // print('Constructor NewTransaction State');
    }

    @override
    void initState() {
        print('initState');
        super.initState(); // use the super keyword to refer to the parent object/state
    }

    @override
    // this is a method that checks if the widget attached to the state changes
    void didUpdateWidget(NewTransaction oldWidget) {
        print('didUpdateWidget');
        super.didUpdateWidget(oldWidget);
    }

    @override
    void dispose() {
        super.dispose();
    }

    void _submitData () {

        if (_amountController.text.isEmpty) {
            return;
        }

        final enteredTitle = _titleController.text;
        final enteredAmount = double.parse(_amountController.text);

        if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
            return;
        }

        // use the widget property to access to the properties of connected widgets in another class
        widget.addNewTxHandler(enteredTitle, enteredAmount, _selectedDate);
        Navigator.of(context).pop();
    }

    void _presentDatePicker() {
        showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now()
        ).then((pickedDate) {
            if (pickedDate == null) {
                return;
            }

            setState(() {
                _selectedDate = pickedDate;
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child: Card(
                elevation: 5,
                child: Container(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 10, // get the value of the space the keyboard occupies
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                            TextField(
                                decoration: InputDecoration(
                                    labelText: 'Title',
                                ),
                                controller: _titleController,
                                onSubmitted: (_) => _submitData(), // the _ indicates the argument is not used in the function body
                            ),
                            TextField(
                                decoration: InputDecoration(
                                    labelText: 'Amount',
                                ),
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                onSubmitted: (_) => _submitData(), // the _ indicates the argument is not used in the function body
                            ),
                            Container(
                                height: 70,
                                child: Row(
                                    children: <Widget>[
                                        Expanded(
                                            child: Text(
                                                _selectedDate == null
                                                ? 'No Date Chosen!'
                                                : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                                            ),
                                        ),
                                        AdaptiveFlatButton('Choose Date', _presentDatePicker)
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
            )
        );
    }
}
