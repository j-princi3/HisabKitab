// http://192.168.0.106:8000/count/princi
// {
//    "notes_500":0,
//    "notes_200":0,
//    "notes_100":0,
//    "time":"2024-03-25"
// }

// ----------------------------------------EXPENSE-----------------------------------------------------------

// http://192.168.0.106:8000/expense/princi
// {
//    "time":"2024-03-25",
//    "no_of_expense":2,
//    "list_of_expense":[{"description":"skjh","amount":90},{"description":"skjh","amount":90}]
// }

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_hisab/pages/components/expenses.dart';
import 'dart:convert';
class APIService {
  static const String baseURL = 'http://192.168.0.106:8000';

  static Future<Map<String, dynamic>> hisab(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int fiveHundredInt = int.tryParse(prefs.getString('fivehundred')!) ?? 0;
    int twoHundredInt = int.tryParse(prefs.getString('twohundred')!) ?? 0;
    int oneHundredInt = int.tryParse(prefs.getString('onehundred')!) ?? 0;
    final storedDateTime = prefs.getString('dateTime')!;
      // Parse string into DateTime object
    DateTime dateTime = DateTime.parse(storedDateTime);
  // Format DateTime object to desired format
  print(dateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    print(formattedDateTime);
    // print(fiveHundredInt);
    // print(twoHundredInt);
    // print(oneHundredInt);
    // print(formattedDateTime);
    // print(expenselist.length);
    // print(jsonExpenses);
    final response2 = await http.post(
  Uri.parse('$baseURL/expense/$username'),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode({
    'time': formattedDateTime,
    'no_of_expense': expenselist.length.toString(),
    'list_of_expense': expenselist, // Sending expenselist directly
  }),
);
    final response1 = await http.post(Uri.parse('$baseURL/count/$username'),
    body:{
      'notes_500': fiveHundredInt.toString(),
      'notes_200': twoHundredInt.toString(),
      'notes_100': oneHundredInt.toString(),
      'time': formattedDateTime ,
    
    });
    if (response1.statusCode == 201 && response2.statusCode == 201) {
      return {'success': true, 'data': {'response1': response1.body, 'response2': response2.body}};
    } else {
      return {'success': false, 'error': 'Status code: ${response1.statusCode} ${response2.statusCode}'};
    }
  }
}
