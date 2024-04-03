import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/base_template.dart'; // Import the BaseTemplate class

class MoneyBag extends StatelessWidget {
  const MoneyBag({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseTemplate(
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
            style:  Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Center(
          child:Text(
            ' - File expense & view balance',
            style: TextStyle(color:Theme.of(context).colorScheme.onPrimary, fontSize: 15),
          ),
        ),  
      ],
    );
  }
}
