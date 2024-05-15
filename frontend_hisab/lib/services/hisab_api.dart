import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_hisab/pages/components/expenses.dart';
import 'dart:convert';

class APIService {
  static const String baseURL = 'http://192.168.0.106:8000';

  static Future<Map<String, dynamic>> hisab(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int fiveHundredInt =int.tryParse(prefs.getString('fivehundred') ?? '0') ?? 0;
    int twoHundredInt = int.tryParse(prefs.getString('twohundred') ?? '0') ?? 0;
    int oneHundredInt = int.tryParse(prefs.getString('onehundred') ?? '0') ?? 0;
    final storedDateTime = prefs.getString('dateTime') ?? '';
    int totalsales = int.tryParse(prefs.getString('totalsales') ?? '0') ?? 0;
    DateTime dateTime = DateTime.parse(storedDateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    if (totalsales > 2147483647 || fiveHundredInt > 2147483647 || twoHundredInt > 2147483647 || oneHundredInt > 2147483647) {
      return {'success': false, 'error': 'Please enter values lesser than 2147483647.'};
    }
    
    if(totalsales==0){
      return {'success': false, 'error': 'Expected sales cannot be Zero.'};
    }      
    if (fiveHundredInt + twoHundredInt + oneHundredInt == 0) {
      return {'success': false, 'error': 'Please enter the notes count.'};
    }
    final response2 = await http.post(
      Uri.parse('$baseURL/expense/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'time': formattedDateTime,
        'no_of_expense': expenselist.length.toString(),
        'list_of_expense': expenselist,
      }),
    );
    final response1 =
        await http.post(Uri.parse('$baseURL/count/$username'), body: {
      'notes_500': fiveHundredInt.toString(),
      'notes_200': twoHundredInt.toString(),
      'notes_100': oneHundredInt.toString(),
      'total_sales': totalsales.toString(),
      'time': formattedDateTime,
    });
    if (response1.statusCode == 201 && response2.statusCode == 201) {
      return {
        'success': true,
        'data': {'response1': response1.body, 'response2': response2.body}
      };
    } else {
      return {
        'success': false,
        'data': 'Status code: ${response1.statusCode} ${response2.statusCode}',
        'error':
            'You have already submitted the notes count and expenses for $formattedDateTime. Please try again for valid date.'
      };
    }
  }
}
