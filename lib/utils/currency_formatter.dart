import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static String format(int amount) {
    return _formatter.format(amount).replaceAll(',', '.');
  }

  static String formatPlain(int amount) {
    final clean = _formatter.format(amount).replaceAll('Rp', '').trim();
    return clean.replaceAll(',', '.');
  }
}
