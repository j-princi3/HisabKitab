import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
DateTime dateTime = DateTime.now();
class NotesCount extends StatefulWidget {
  const NotesCount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotesCountState createState() => _NotesCountState();
}

class _NotesCountState extends State<NotesCount> {
  TextEditingController salestoday = TextEditingController();
  TextEditingController fivehundred = TextEditingController();
  TextEditingController twohundred = TextEditingController();
  TextEditingController onehundred = TextEditingController();
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    // Retrieve saved values from SharedPreferences when the widget is initialized
    retrieveSavedValues();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap your widget tree with GestureDetector
      onTap: () {
        // Dismiss the keyboard when tapped outside of the text field
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
      width: 300,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: salestoday,
        keyboardType: TextInputType.number,
        maxLength: 15,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.right,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Enter today's sales amount",
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          counterText: "",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        ),
        onChanged: (value) {
          setState(() {
            totalAmount = calculateTotalAmount();
          });
          // Save changed values to SharedPreferences when they are modified
          saveChangedValues();
        },
      ),
    ),
          Container(
            width: 174,
            height: 47,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  Center(
              child: Text(
                'Notes',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
               Text(
                '$totalAmount',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              buildTextField(fivehundred, "500"),
              const SizedBox(height: 5),
              buildTextField(twohundred, "200"),
              const SizedBox(height: 5),
              buildTextField(onehundred, "100"),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return Container(
      width: 176,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 7,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.right,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          counterText: "",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        ),
        onChanged: (value) {
          setState(() {
            totalAmount = calculateTotalAmount();
          });
          // Save changed values to SharedPreferences when they are modified
          saveChangedValues();
        },
      ),
    );
  }

  int calculateTotalAmount() {
    int fiveHundredValue = int.tryParse(fivehundred.text) ?? 0;
    int twoHundredValue = int.tryParse(twohundred.text) ?? 0;
    int oneHundredValue = int.tryParse(onehundred.text) ?? 0;
    return (fiveHundredValue * 500) + (twoHundredValue * 200) + (oneHundredValue * 100);
  }

  Future<void> saveChangedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fivehundred', fivehundred.text);
    prefs.setString('twohundred', twohundred.text);
    prefs.setString('onehundred', onehundred.text);
    prefs.setString('totalsales', salestoday.text);
    saveDateTime(dateTime);
  }

  Future<void> retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fivehundred.text = prefs.getString('fivehundred') ?? '';
      twohundred.text = prefs.getString('twohundred') ?? '';
      onehundred.text = prefs.getString('onehundred') ?? '';
      salestoday.text = prefs.getString('totalsales') ?? '';
      totalAmount = calculateTotalAmount();
    });
  }
}


Future<void> saveDateTime(DateTime dateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dateTime', dateTime.toString());
  }