import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart'; // Import the BaseTemplate class
import 'package:frontend_hisab/pages/components/viewhistory.dart'; // Import the TableBasicsExample class
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseTemplate(
      // Use BaseTemplate instead of Scaffold
      children: [
        // Add your additional components here
        Padding(
          padding:const EdgeInsets.only(
            top: 10,
            left: 20,
          ), // Add space at the top
          child: Text(
            'History',
            style:  Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Column(
        children: [
          Center(
            child: Text(
          ' - See history using calendar!',
          style: TextStyle(color:Theme.of(context).colorScheme.onPrimary, fontSize: 15),
        ),
          ),
        
        const TableBasicsExample(),
      ],
    ),
  ],
  );
  }
}