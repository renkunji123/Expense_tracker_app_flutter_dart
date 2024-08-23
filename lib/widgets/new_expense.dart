import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  void dispose () {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _amountController,
              maxLength: 50,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Amount'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print('${_titleController.text} ${_amountController.text}');
                  },
                  child: const Text('Save Expense')),
              const SizedBox(width: 170,),
              ElevatedButton (
                onPressed: () {
                  Navigator.pop(
                    context
                  );
                },
                    child: const Text('Exit')),
            ],
          )
        ],
      ),
    );
  }

}