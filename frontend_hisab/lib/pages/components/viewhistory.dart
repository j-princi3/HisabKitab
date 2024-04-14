import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({Key? key}) : super(key: key);

  @override
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
    setState(() {
      // Retrieve the selected date from shared preferences
      String? selectedDate = prefs.getString('selected_date');
      if (selectedDate != null) {
        _selectedDay = DateTime.parse(selectedDate);
      }
    });
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
