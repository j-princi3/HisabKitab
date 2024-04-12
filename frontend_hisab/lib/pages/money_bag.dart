import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart';

class MoneyBag extends StatelessWidget {
  final dynamic data;
  const MoneyBag({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> response = jsonDecode(data);
    List<dynamic> balance = response['BankBalnce'];
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
            'Money bag - File expense & view balance',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        // Center(
        //   child: Text(
        //     ' - File expense & view balance',
        //     style: TextStyle(
        //         color: Theme.of(context).colorScheme.onPrimary, fontSize: 15),
        //   ),
        // ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: balance.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                balance[index].toString(),
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ],
    );
  }
}
