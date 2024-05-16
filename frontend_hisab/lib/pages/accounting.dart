
import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart'; // Import the BaseTemplate class
import 'package:frontend_hisab/pages/components/notes_count.dart';
import 'package:frontend_hisab/pages/components/expenses.dart';
import 'package:frontend_hisab/pages/components/calendar.dart';
class AccountingPage extends StatelessWidget {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    bool someBooleanValue = true;
    return GestureDetector(
      onTap: () {
        // Dismiss the keypad when clicked on the screen
        FocusScope.of(context).unfocus();
      },
      child: BaseTemplate(
        // Use BaseTemplate instead of Scaffold
        children: [
          // Add your additional components here
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
            ), // Add space at the top
            child: Text(
              'Accounting Page',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Column(
            children: [
               Text(
                ' - File sales',
                style: TextStyle(color:Theme.of(context).colorScheme.onPrimary, fontSize: 15),
              ),
              const SizedBox(height: 20),
              const DatePickerExample(),
              const NotesCount(),
              const SizedBox(height: 20),
              ExpenseItems(someValue: someBooleanValue),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}


