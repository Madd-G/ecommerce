import 'package:ecommerce/core.dart';

extension IntExt on int {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(this);
}
