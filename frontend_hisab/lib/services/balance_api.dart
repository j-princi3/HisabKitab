// http://192.168.0.106:8000/getbankbalance/princi
import 'package:http/http.dart' as http;

class APIService{
  static const String baseURL = 'http://192.168.0.106:8000';
  static Future<Map<String, dynamic>> balance(String username) async {
    final response = await http.get(Uri.parse('$baseURL/getbankbalance/$username'));
    if (response.statusCode == 200) {
      return {'success': true, 'data': response.body};
    } else {
      return {'success': false, 'error': 'Failed to load balance'};
    }
  }

}