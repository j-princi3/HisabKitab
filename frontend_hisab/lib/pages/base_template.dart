import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/login.dart';
import 'package:frontend_hisab/pages/money_bag.dart';
import 'package:frontend_hisab/pages/accounting.dart';
import 'package:frontend_hisab/pages/calendar.dart';

class BaseTemplate extends StatelessWidget {
  final List<Widget> children;

  const BaseTemplate({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: const Color(0xFFE1F0DA), // Set background color
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
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
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 20,
                                  ), // Add space at the top
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 30,
                                    color: Color(0xFF6FA94E),
                                  ),
                                ),
                              ),
                          children[0],
                            ],
                          ),
                          children[1],
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    color: const Color(0xFFD4E7C5),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AccountingIcon(),
                        MoneyBagIcon(),
                        CalendarIcon(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MoneyBagIcon extends StatelessWidget {
  const MoneyBagIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MoneyBag(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/img/money-bag.png',
          width: 60,
          height: 52,
        ),
      ),
    );
  }
}

class AccountingIcon extends StatelessWidget {
  const AccountingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AccountingPage(key: Key('accounting')),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/img/accounting.png',
          width: 60,
          height: 52,
        ),
      ),
    );
  }
}

class CalendarIcon extends StatelessWidget {
  const CalendarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CalendarPage(key: Key('Calendar')),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/img/calendar.png',
          width: 60,
          height: 52,
        ),
      ),
    );
  }
}