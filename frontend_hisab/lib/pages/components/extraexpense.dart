import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NotesCountexpense extends StatefulWidget {
  const NotesCountexpense({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotesCountexpenseState createState() => _NotesCountexpenseState();
}

class _NotesCountexpenseState extends State<NotesCountexpense> {
  TextEditingController fivehundredexpense = TextEditingController();
  TextEditingController twohundredexpense = TextEditingController();
  TextEditingController onehundredexpense = TextEditingController();
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
            width: 174,
            height: 47,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  Center(
              child: Text(
                'Extra Expense',
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
              buildTextField(fivehundredexpense, "500"),
              const SizedBox(height: 5),
              buildTextField(twohundredexpense, "200"),
              const SizedBox(height: 5),
              buildTextField(onehundredexpense, "100"),
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
    int fiveHundredexpenseValue = int.tryParse(fivehundredexpense.text) ?? 0;
    int twoHundredexpenseValue = int.tryParse(twohundredexpense.text) ?? 0;
    int oneHundredexpenseValue = int.tryParse(onehundredexpense.text) ?? 0;
    return (fiveHundredexpenseValue * 500) + (twoHundredexpenseValue * 200) + (oneHundredexpenseValue * 100);
  }

  Future<void> saveChangedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fivehundredexpense', fivehundredexpense.text);
    prefs.setString('twohundredexpense', twohundredexpense.text);
    prefs.setString('onehundredexpense', onehundredexpense.text);
  }

  Future<void> retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fivehundredexpense.text = prefs.getString('fivehundredexpense') ?? '';
      twohundredexpense.text = prefs.getString('twohundredexpense') ?? '';
      onehundredexpense.text = prefs.getString('onehundredexpense') ?? '';
      totalAmount = calculateTotalAmount();
    });
  }
}
