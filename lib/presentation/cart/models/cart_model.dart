import 'package:ecommerce/core.dart';

import '../../../data/models/responses/products_response_model.dart';

class CartModel {
  final Product product;
  int quantity;

  CartModel({
    required this.product,
    this.quantity = 0,
  });

  String get priceFormat => product.attributes.price.currencyFormatRp;
}
