import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_hisab/pages/base_template.dart'; // Import the BaseTemplate class
import 'package:frontend_hisab/pages/components/notes_count.dart';
import 'package:frontend_hisab/pages/components/expenses.dart';

class AccountingPage extends StatelessWidget {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keypad when clicked on the screen
        FocusScope.of(context).unfocus();
      },
      child: const BaseTemplate(
        // Use BaseTemplate instead of Scaffold
        children: [
          // Add your additional components here
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
            ), // Add space at the top
            child: Text(
              'Accounting Page',
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Color(0xFF6FA94E),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                ' - File sales',
                style: TextStyle(color: Color(0xFF6FA94E)),
              ),
              SizedBox(height: 25),
              NotesCount(),
               SizedBox(height: 25),
              ExpenseItems(),
            ],
          ),
        ],
      ),
    );
  }
}
