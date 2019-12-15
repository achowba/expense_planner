// create a class a a blueprint for a dart object
import 'package:flutter/cupertino.dart';

class Transaction {
    final String id;
    final String title;
    final double amount;
    final DateTime date;

    // create a constructor with named arguments
    Transaction({@required this.id, @required this.title, @required this.amount, @required this.date});
}
