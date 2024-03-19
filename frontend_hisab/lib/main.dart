import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(top: 200), // Add space at the top
              child: Text(
                'Hisab kitab',
                style: TextStyle(
                  fontSize: 60,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF6FA94E),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              width: 220,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFBFD8AF), // Button color
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Center(
                  child: Text(
                    ' Get Started ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF6FA94E), // Button text color
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
