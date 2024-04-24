import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class APIService {
  static const String baseURL = 'http://192.168.0.106:8000'; // Update with your base URL

  static Future<Map<String, dynamic>> getDate(DateTime selectedDay) async  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedDate = prefs.getString('dateTime') ?? '';
    String currentDate = DateFormat('yyyy-MM-dd').format(selectedDate as DateTime);

    // Make the API call with the current date
    final response = await http.get(Uri.parse('$baseURL/date/?date=$currentDate'));

    if (response.statusCode == 200) {

      // If the server returns a 200 OK response, parse the JSON response
      print(response.body);
      return {'success': true, 'data': response.body};
    } else {
      // If the server returns an unsuccessful response code, return an error message
      return {'success': false, 'error': 'Failed to get date. Status code: ${response.statusCode}'};
    }
  }
}

