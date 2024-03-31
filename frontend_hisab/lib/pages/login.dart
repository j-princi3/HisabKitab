import 'package:flutter/material.dart';
import 'package:frontend_hisab/main.dart';
import 'package:frontend_hisab/pages/accounting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_hisab/services/login_api.dart';
void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}

final passwordController = TextEditingController();
final usernameController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffe1f0da), // Background color E1F0DA
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 33,
                color: const Color(0xFF99BC85), // Top rectangle color
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, left: 20), // Add space at the top
                      child: Icon(Icons.arrow_back_ios,size: 30, color: Color(0xFF6FA94E)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20), // Add space at the top
                    child: Text(
                      'Hisab kitab',
                      style: TextStyle(
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6FA94E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Container(
                width: 278,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffbfd8af), //Color(0xFF6FA94E)
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xff6fa94e)), // Add black border
                ),
                child: TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: Color(0xFF6FA94E)),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Color(0xff6fa94e)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const PasswordField(),
              const SizedBox(height: 30),
              Container(
  width: 278,
  height: 48,
  decoration: BoxDecoration(
    color: const Color(0xFFBFD8AF),
    borderRadius: BorderRadius.circular(20),
  ),
  child: ElevatedButton(
    onPressed: () async {
      final response = await APIService.login(
        usernameController.text.toString(),
        passwordController.text.toString(),
      );
      if (response["success"] == true) {
        // Login successful
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setString('username', usernameController.text.toString());
          prefs.setString('password', passwordController.text.toString());
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountingPage()),
        );
      } else {
        // Login failed
        // Add your logic here, such as displaying an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Invalid username or password. Please try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffbfd8af),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: const Text(
      'Login',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff6fa94e)),
    ),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
  if (mounted) {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside of text field
      },
      child: Container(
        width: 278,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xffbfd8af),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF6FA94E)), // Add black border
        ),
        child: TextFormField(
          controller: passwordController,
          style: const TextStyle(color: Color(0xFF6FA94E)),
          obscureText: _obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12), // Adjust vertical padding
            hintText: 'Password',
            hintStyle: const TextStyle(color: Color(0xFF6FA94E)),
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF6FA94E),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void getValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  usernameController.text = prefs.getString('username') ?? '';
  passwordController.text = prefs.getString('password') ?? '';
}
