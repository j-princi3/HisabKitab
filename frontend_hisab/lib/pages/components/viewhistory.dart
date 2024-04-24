import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend_hisab/services/searchwithdate_api.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now(); // Initialize _selectedDay to DateTime.now()

  @override
  void initState() {
    super.initState();
    _loadSelectedDate();
  }

void _loadSelectedDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedDate = prefs.getString('selected_date');
  if (selectedDate != null) {
    setState(() {
      _selectedDay = DateTime.parse(selectedDate);
    });
    final response = await APIService.getDate(_selectedDay);
    if (response['success']) {
      // If the API call is successful, update the UI with the response data
      print(response['data']);
    } else {
      // If the API call is unsuccessful, show an error message
      print(response['error']);
    }
  }
}

  void _saveSelectedDate(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save the selected date to shared preferences
    await prefs.setString('selected_date', date.toString());
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.parse('2024-04-11'),
      lastDay: DateTime.now(),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          // Save the selected date when it changes
          _saveSelectedDate(selectedDay);
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
