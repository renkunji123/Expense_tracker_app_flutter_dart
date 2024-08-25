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

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3) ,
          content: const Text('Expense Deleted.'),
          action: SnackBarAction(label: 'Undo', onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
                }
              );
            },
          ),
        ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expense found. Start adding some!'),);

    if (_registeredExpenses.isNotEmpty ) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense,);
    }
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
          Expanded(
              child: mainContent,
          ),
        ],
      ),
    );
  }
}