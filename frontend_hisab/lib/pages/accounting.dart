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
      child: BaseTemplate(
        // Use BaseTemplate instead of Scaffold
        children: [
          // Add your additional components here
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
            ), // Add space at the top
            child: Text(
              'Accounting Page',
              style: TextStyle(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                color: Color(0xFF6FA94E),
              ),
            ),
          ),
          Column(
            children: [
              const Text(
                ' - File sales',
                style: TextStyle(color: Color(0xFF6FA94E)),
              ),
              const SizedBox(height: 25),
              const NotesCount(),
              const SizedBox(height: 25),
              const ExpenseItems(),
              const SizedBox(height: 25),
              Container(
                width: 174,
                height: 47,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4E7C5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xFF6FA94E),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
