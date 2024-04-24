import 'package:flutter/material.dart';
import 'package:frontend_hisab/pages/login.dart';
import 'package:frontend_hisab/pages/money_bag.dart';
import 'package:frontend_hisab/pages/accounting.dart';
import 'package:frontend_hisab/pages/history_view.dart';
import 'package:frontend_hisab/services/balance_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              backgroundColor: Theme.of(context).colorScheme.background, // Set background color
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 26,
                            color:Theme.of(context).primaryColor, // Top rectangle color
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
                                child:  Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 20,
                                  ), // Add space at the top
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 30,
                                    color: Theme.of(context).colorScheme.onPrimary,
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
                    color: Theme.of(context).colorScheme.tertiary,
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
      onTap: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final response=APIService.balance(prefs.getString('username') ?? '');
        var responseData = await response;
        if(responseData['success']){
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) =>  MoneyBag(data: responseData['data'],),
            )
          );
      }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/img/money-bag.png',
          color: Theme.of(context).colorScheme.onPrimary,
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
          color: Theme.of(context).colorScheme.onPrimary,
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
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}