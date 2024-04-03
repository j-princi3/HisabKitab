
import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart'; // Import the BaseTemplate class
import 'package:frontend_hisab/pages/components/notes_count.dart';
import 'package:frontend_hisab/pages/components/expenses.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              const SizedBox(height: 25),
              const NotesCount(),
              const SizedBox(height: 25),
              const ExpenseItems(),
              const SizedBox(height: 25),
              Container(
                width: 180,
                height: 47,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () => getUserNamefromSharedPref(),
                    child: Text('Save',
                    style: Theme.of(context).textTheme.bodyMedium,),
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

void getUserNamefromSharedPref() {
  // Get the username from SharedPreferences
  SharedPreferences.getInstance().then((prefs) {
    final username = prefs.getString('username');
    final fivehundred = prefs.getString('fivehundred');
    final twohundred = prefs.getString('twohundred');
    final onehundred = prefs.getString('onehundred');
    print('Username: $username');
    print('500: $fivehundred');
    print('200: $twohundred');
    print('100: $onehundred');
  });
}


