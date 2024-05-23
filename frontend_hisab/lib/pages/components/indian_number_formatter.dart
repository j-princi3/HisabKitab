import 'package:intl/intl.dart';

String formatIndianNumber(int number) {
  final indianFormat = NumberFormat('##,##,##0', 'en_IN');
  return indianFormat.format(number);
}
