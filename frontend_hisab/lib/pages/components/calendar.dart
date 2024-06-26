import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Flutter code sample for [showDatePicker].
DateTime now = DateTime.now();
int year = DateTime.now().year;
int month = DateTime.now().month;
int day = DateTime.now().day;
void main() => runApp(const DatePickerApp());

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

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
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

  @pragma('vm:entry-point')
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
          firstDate: DateTime(now.year, now.month, now.day - 5),
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

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        time = _selectedDate.value;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
        saveDateTime(_selectedDate.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
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
        // if (prefs.getString('dateTime') ?? ''==)
        '${time.day}/${time.month}/${time.year}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

Future<void> saveDateTime(DateTime dateTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('dateTime', dateTime.toString());
}

Future<String> getDateTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final storedDateTime = prefs.getString('dateTime') ?? '';
  return storedDateTime;
}
