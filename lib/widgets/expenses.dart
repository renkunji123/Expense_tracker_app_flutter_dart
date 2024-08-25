import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';


import '../models/expense.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}
class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.food,
    ),
    Expense(
      title: 'flutter ',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.learn,
    )
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      context: context,
        builder: (ctx) =>  NewExpense(onAddExpense: _addExpense,),
    );
  }
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
          ),

        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child:
          ExpensesList(expenses: _registeredExpenses),)
        ],
      ),
    );
  }
}