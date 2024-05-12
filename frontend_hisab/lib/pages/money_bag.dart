import 'dart:convert';
import 'package:frontend_hisab/pages/components/extraexpense.dart';
import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_hisab/services/extrasexpense_api.dart';
class MoneyBag extends StatelessWidget {
  final dynamic data;
  const MoneyBag({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
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
        Container(
          width: 180,
          height: 47,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final response = await APIService.extrasexpense(prefs.getString('username') ?? '');
                if (response['success'] == true) {
                  prefs.setString('fivehundredexpense', '');
                  prefs.setString('twohundredexpense', '');
                  prefs.setString('onehundredexpense', '');
                  prefs.setString('description', '');
                  showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                dialogBackgroundColor:
                                    Theme.of(context).colorScheme.background),
                            child: AlertDialog(
                              title: const Text(
                                'Success',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                  'Your expense is saved ,check out pages for details.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ],
                            ),
                          );
                        });
                }
                else{// Login failed
                final msg = response['error'];
                      // Add your logic here, such as displaying an error message
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                dialogBackgroundColor:
                                    Theme.of(context).colorScheme.background),
                            child: AlertDialog(
                              title: const Text(
                                'Failed',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content:  Text(
                                  '$msg.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ],
                            ),
                          );
                        });
                }
              },
              child: Text(
                ' Save ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        ],
        ),
      ],
    );
  }
}
