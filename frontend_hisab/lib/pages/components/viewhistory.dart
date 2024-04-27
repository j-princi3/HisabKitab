import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend_hisab/services/searchwithdate_api.dart';
import 'dart:convert';
var t={};
class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay =
      DateTime.now(); // Initialize _selectedDay to DateTime.now()
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Column(
      children: [
        t.isEmpty
            ? const Text('Select the date to view history')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: t.length,
                itemBuilder: (context, index) {
                  return ListTile(
  title: Row(
    children: [
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            t.keys.elementAt(index),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      const SizedBox(width: 8), // Add spacing between name and balance
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            t.values.elementAt(index).toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    ],
  ),
);
                },
              ),
        TableCalendar(
          firstDay: DateTime.parse('2024-04-11'),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            
                t={'Message': 'Seclect the date'};
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) async {
            if (!isSameDay(_selectedDay, selectedDay)) {
              String formattedDateTime =
                  DateFormat('yyyy-MM-dd').format(selectedDay);
              final response = APIService.getDate(formattedDateTime);
              final responseData = await response;
              if (responseData['success']) {
                // If the API call is successful, update the UI with the response data
                t = jsonDecode(responseData['data']);
              } else {
                // If the API call is unsuccessful, show an error message
                t = {"Message": "Data was not found for the selected date"};
              }
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
        ),
      ],
    ),
    );
  }
}