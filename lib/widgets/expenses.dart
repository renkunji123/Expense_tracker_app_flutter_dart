import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/widgets/chart/chart.dart';


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

  bool _isDarkMode = false;


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
    ScaffoldMessenger.of(context).clearSnackBars();
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

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
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
    return MaterialApp(
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // White background in dark mode
          titleTextStyle: TextStyle(
            color: Colors.black, // Black text in dark mode
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black), // Black icons in dark mode
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text("Flutter Expense Tracker"),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add),
            ),
            IconButton(
              icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          const Text('The Chart'),
          Expanded(
              child: mainContent,
          ),
        ],
      ),
      ),
    );
  }
}