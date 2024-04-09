import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_hisab/pages/money_bag.dart';
var expenselist = [];

class ExpenseItem {
  final String description;
  final int amount;

  ExpenseItem(this.description, this.amount);
}

class ExpenseItems extends StatefulWidget {
  const ExpenseItems({super.key});

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
              onPressed: () => {
                getUserNamefromSharedPref(_expenseItems),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoneyBag()),
                )
              },
              child: Text(
                ' Save ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
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
    final username = prefs.getString('username');
    int fiveHundredInt = int.tryParse(prefs.getString('fivehundred')!) ?? 0;
    int twoHundredInt = int.tryParse(prefs.getString('twohundred')!) ?? 0;
    int oneHundredInt = int.tryParse(prefs.getString('onehundred')!) ?? 0;

    print('Username: $username');
    print('500: $fiveHundredInt');
    print('200: $twoHundredInt');
    print('100: $oneHundredInt');

    // Print or process expense items

    print('Expense Items:');
    for (var item in expenseItems) {
      expenselist.add({'description': item.description, 'amount': item.amount});
      print(expenselist);
    }
    expenseItems.clear();
    expenselist.clear();
    prefs.setString('fivehundred', '');
    prefs.setString('twohundred', '');
    prefs.setString('onehundred', '');
  });
}
