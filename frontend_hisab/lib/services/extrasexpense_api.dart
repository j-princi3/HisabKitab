import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:frontend_hisab/pages/components/expenses.dart';

class APIService {
  static const String baseURL = 'http://192.168.0.106:8000';

  static Future<Map<String, dynamic>> extrasexpense(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int fiveHundredInt =int.tryParse(prefs.getString('fivehundredexpense') ?? '0') ?? 0;
    int twoHundredInt = int.tryParse(prefs.getString('twohundredexpense') ?? '0') ?? 0;
    int oneHundredInt = int.tryParse(prefs.getString('onehundredexpense') ?? '0') ?? 0;
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (fiveHundredInt > 2147483647 || twoHundredInt > 2147483647 || oneHundredInt > 2147483647) {
      return {'success': false, 'error': 'Please enter values lesser than 2147483647'};
    }    
    if (fiveHundredInt + twoHundredInt + oneHundredInt == 0) {
      return {'success': false, 'error': 'Please enter the notes count'};
    }
    
    final response =
        await http.post(Uri.parse('$baseURL/extraexpense/$username'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
      'notes_500': fiveHundredInt.toString(),
      'notes_200': twoHundredInt.toString(),
      'notes_100': oneHundredInt.toString(),
      'time': formattedDateTime,
      'no_of_expense': expenselist.length.toString(),
      'list_of_expense': expenselist,
    }),);
    if (response.statusCode == 201 ) {
      return {
        'success': true,
        'data': {'response': response.body}
      };
    } else {
      return {
        'success': false,
        'data': 'Status code: ${response.statusCode}',
        'error':
            'Your expenses for $formattedDateTime are not saved. Please try again.'
      };
    }
  }
}
