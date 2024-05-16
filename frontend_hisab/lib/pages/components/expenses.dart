import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_hisab/services/hisab_api.dart' as salesservice;
import 'package:frontend_hisab/services/extrasexpense_api.dart' as expenseservice;
var expenselist = [];

class ExpenseItem {
  final String description;
  final int amount;

  ExpenseItem(this.description, this.amount);
}

class ExpenseItems extends StatefulWidget {
  final bool someValue;
  const ExpenseItems({super.key, required this.someValue});

  @override
  // ignore: library_private_types_in_public_api
  _ExpenseItemsState createState() => _ExpenseItemsState();
}

class _ExpenseItemsState extends State<ExpenseItems> {
  final List<ExpenseItem> _expenseItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 174,
          height: 47,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Expenses',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _expenseItems.add(ExpenseItem('', 0));
                  });
                },
                child: Icon(Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
        ),
        Text(
          '${_expenseItems.fold(0, (prev, item) => prev + (item.description.isEmpty ? 0 : item.amount))}',
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(_expenseItems.length, (index) {
            return ExpenseBox(
              expenseItem: _expenseItems[index],
              onChanged: (description) {
                setState(() {
                  _expenseItems[index] =
                      ExpenseItem(description, _expenseItems[index].amount);
                });
              },
              onAmountChanged: (amount) {
                setState(() {
                  _expenseItems[index] =
                      ExpenseItem(_expenseItems[index].description, amount);
                });
              },
              onDelete: () {
                setState(() {
                  _expenseItems.removeAt(index);
                });
              },
            );
          }),
        ),
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
              onPressed: () async {
                getUserNamefromSharedPref(_expenseItems);
                final prefs = await SharedPreferences.getInstance();
                if(widget.someValue == true){
                  
                final response =
                    await salesservice.APIService.hisab(prefs.getString('username') ?? '');
                if (response['success'] == true ){
                  expenselist.clear();
                  prefs.setString('fivehundred', '');
                  prefs.setString('twohundred', '');
                  prefs.setString('onehundred', '');
                  prefs.setString('totalsales', '');
                  prefs.setString('dateTime', DateTime.now().toString());
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
                                'Your accounting is saved ,check out pages for details.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  // Login failed
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
                            content: Text('$msg.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }
              else{
                if(widget.someValue == false){
                  final response = await expenseservice.APIService.extrasexpense(prefs.getString('username') ?? '');
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
              }
              }
              
              },
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class ExpenseBox extends StatelessWidget {
  final ExpenseItem expenseItem;
  final ValueChanged<String> onChanged;
  final ValueChanged<int> onAmountChanged;
  final VoidCallback onDelete;

  const ExpenseBox({
    super.key,
    required this.expenseItem,
    required this.onChanged,
    required this.onAmountChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                counterText: '',
              ),
              maxLength: 20,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => onAmountChanged(int.tryParse(value) ?? 0),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                counterText: '',
              ),
              maxLength: 7,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: onDelete,
        ),
      ],
    );
  }
}

void getUserNamefromSharedPref(List<ExpenseItem> expenseItems) {
  SharedPreferences.getInstance().then((prefs) {
    for (var item in expenseItems) {
      if (item.amount == 0 || item.description.isEmpty) {
        continue;
      }
      expenselist.add({'description': item.description, 'amount': item.amount});
    }
    expenseItems.clear();
  });
}
