import 'dart:convert';
import 'package:frontend_hisab/pages/components/extraexpense.dart';
import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart';
import 'package:frontend_hisab/pages/components/expenses.dart';
class MoneyBag extends StatelessWidget {
  final dynamic data;
  const MoneyBag({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
     bool someBooleanValue = false;
    Map<String, dynamic> response = jsonDecode(data);
    List<dynamic> balance = response['BankBalnce'];
    List names=['500 :','200 :','100 :','Total :','Date:'];
    return BaseTemplate(
      // Use BaseTemplate instead of Scaffold
      children: [
        // Add your additional components here
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
          ), // Add space at the top
          child: Text(
            'Money bag ',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Column(
        children: [
          Center(
            child: Text(
              ' - File expense & view balance',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 15),
            ),
          ),
          ListView.builder(
          shrinkWrap: true,
          itemCount: balance.length,
          itemBuilder: (context, index) {
            return ListTile(
  title: Row(
    children: [
      Text(
        names[index],
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(width: 8), // Add spacing between name and balance
      Text(
        balance[index].toString(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ],
  ),
);

          },
        ),
        const SizedBox(height: 20),
        const NotesCountexpense(),
        const SizedBox(height: 20),
        ExpenseItems(someValue: someBooleanValue),
         const SizedBox(height: 20),
        ],
        ),
      ],
    );
  }
}
