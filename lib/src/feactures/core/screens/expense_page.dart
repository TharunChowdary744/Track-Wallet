import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Expense Page"),
    );
  }
}
