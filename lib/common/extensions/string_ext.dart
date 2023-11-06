import 'package:ecommerce/core.dart';

extension StringExt on String {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(int.parse(this));
}
