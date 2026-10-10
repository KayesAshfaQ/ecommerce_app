import 'package:ecommerce_app/features/auth/models/user_model.dart';
import 'package:ecommerce_app/features/cart/models/cart_item.dart';
import 'package:ecommerce_app/features/order/models/shipping_address_model.dart';
import 'package:flutter/foundation.dart';

import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
  OrderModel? _latestOrder;
  bool _isSubmitting = false;
  bool _isLoadingHistory = false;
  String? _errorMessage;

  List<OrderModel> get orders => _orders;
  OrderModel? get latestOrder => _latestOrder;
  bool get isSubmitting => _isSubmitting;
  bool get isLoadingHistory => _isLoadingHistory;
  String? get errorMessage => _errorMessage;

  ShippingAddressModel getInitialShippingAddress(UserModel? authUser) {
    throw Exception('Not implemented');
  }

  Future<OrderModel?> placeOrder({
    required List<CartItem> items,
    required double subtotal,
    required double tax,
    required double total,
    required ShippingAddressModel shippingAddress,
    required paymentMethod,
    required String paymentStatus,
    String? transactionId,
    required user,
  }) async {
    throw Exception();
  }
}
