import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_hisab/app_theme.dart';
import 'package:frontend_hisab/pages/login.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter services are initialized
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 26,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 200), // Add space at the top
              child: Text(
                'Hisab kitab',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 100),
            Container(
              width: 220,
              height: 52,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary, // Button color
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Center(
                  child: Text(
                    ' Get Started ',
                    style:Theme.of(context).textTheme.bodyMedium,
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
