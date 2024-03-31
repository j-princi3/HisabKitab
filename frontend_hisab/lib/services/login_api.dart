import 'package:http/http.dart' as http;

class APIService {
  static const String baseURL = 'http://192.168.0.106:8000';

  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.get(Uri.parse('$baseURL/login/?username=$username&password=$password'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return {'success': true, 'data': response.body};
    } else {
      // If the server returns an unsuccessful response code, return an error message
      return {'success': false, 'error': 'Failed to login. Status code: ${response.statusCode}'};
    }
  }
}
