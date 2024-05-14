import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend_hisab/services/searchwithdate_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

var t = {};

DateTime now = DateTime.now();
int year = DateTime.now().year;
int month = DateTime.now().month;
int day = DateTime.now().day;

class DatePickerApp extends StatelessWidget {
  const DatePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      restorationScopeId: 'app',
      home: const DatePickerExample(restorationId: 'main'),
    );
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  DateTime time = DateTime(year, month, day);
  @override
  void initState() {
    super.initState();
    _initializeTime();
  }

  _initializeTime() {
    getDateTime().then((dateTime) {
      setState(() {
        if (dateTime != '') {
          time = DateTime.parse(dateTime);
        }
      });
    });
  }

  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(year, month, day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime now = DateTime.now();
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2024, 04, 12),
          lastDate: DateTime(now.year, now.month, now.day),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) async {
    if (newSelectedDate != null) {
      // Perform asynchronous work outside of setState
      String formattedDateTime =
          DateFormat('yyyy-MM-dd').format(newSelectedDate);
      final response = await APIService.getDate(formattedDateTime);
      final responseData = response['success']
          ? jsonDecode(response['data'])
          : {"Message": "Data was not found for the selected date"};

      setState(() {
        // Update the state synchronously inside setState
        _selectedDate.value = newSelectedDate;
        time = _selectedDate.value;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
        saveDateTime(_selectedDate.value);
        t = responseData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              _restorableDatePickerRouteFuture.present();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.tertiary),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.0)), // Change color and width here
              // Add more style properties as needed
            ),
            child: Text(
              '${time.day}/${time.month}/${time.year}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(), // Add this line

            shrinkWrap:
                true, // Use this to prevent the ListView from expanding to the maximum possible height
            itemCount: t.length,

            itemBuilder: (context, index) {
              String key = t.keys.elementAt(index);
              var value = t[key];
              if (RegExp(r'^\d+\)').hasMatch(key)) {
                // Extract the next part of the key after ')'
                key = key.substring(key.indexOf(')') + 1).trim();
              }
              return ListTile(
                title: Text(
                  '$key: $value',
                  style: key == '1' ||
                          key == '2' ||
                          key == '3' ||
                          key == '4' ||
                          key == '5'
                      ? const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<void> saveDateTime(DateTime dateTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('dateTime1', dateTime.toString());
}

Future<String> getDateTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final storedDateTime = prefs.getString('dateTime1') ?? '';
  return storedDateTime;
}
