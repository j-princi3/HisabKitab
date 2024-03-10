import 'package:flutter/material.dart';

class ExpenseItems extends StatefulWidget {
  const ExpenseItems({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExpenseItemsState createState() => _ExpenseItemsState();
}

class _ExpenseItemsState extends State<ExpenseItems> {
  List<ExpenseBox> expenseBoxes = [];

  // Function to remove an expense box from the list
  void removeExpenseBox(ExpenseBox expenseBox) {
    setState(() {
      expenseBoxes.remove(expenseBox);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensure the column takes minimal space
      children: [
        // Header Box with Icon Button
        Container(
          width: 174,
          height: 47,
          decoration: BoxDecoration(
            color: const Color(0xFFD4E7C5), // Changed the color here
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Expenses',
                  style: TextStyle(
                    color: Color(0xFF6FA94E),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    expenseBoxes.add(ExpenseBox(onDelete: () => removeExpenseBox(expenseBoxes.last)));
                  });
                },
                child: const Icon(Icons.add, color: Color(0xFF6FA94E)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10), // Add some space between header box and count
        Column(
          children: expenseBoxes,
        ),
      ],
    );
  }
}

class ExpenseBox extends StatelessWidget {
  final VoidCallback? onDelete;

  const ExpenseBox({super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: Color(0xFF6FA94E)), // Set text color
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Color(0xFF6FA94E)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4E7C5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6FA94E)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4E7C5)),
                ),
                counterText: '', // Remove character count
              ),
              maxLength: 20,
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right, // Align text to the right
              style: TextStyle(color: Color(0xFF6FA94E)), // Set text color
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Color(0xFF6FA94E)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4E7C5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6FA94E)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4E7C5)),
                ),
                counterText: '', // Remove character count
              ),
              maxLength: 7,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: const Color(0xFF6FA94E), // Set delete icon color
          onPressed: onDelete,
        ),
      ],
    );
  }
}

