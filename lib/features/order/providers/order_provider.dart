import 'dart:math' show Random;

import 'package:ecommerce_app/features/auth/models/user_model.dart';
import 'package:ecommerce_app/features/cart/models/cart_item.dart';
import 'package:ecommerce_app/features/order/models/payment_method.dart';
import 'package:ecommerce_app/features/order/models/shipping_address_model.dart';
import 'package:flutter/foundation.dart';

import '../data/order_repository.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderRepository orderRepository;

  bool _isSubmitting = false;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  bool _isGatewayLoading = false;
  List<OrderModel> _orders = [];
  OrderModel? _latestOrder;
  bool _isLoadingHistory = false;
  String? _errorMessage;

  bool get isSubmitting => _isSubmitting;
  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;
  bool get isGatewayLoading => _isGatewayLoading;
  List<OrderModel> get orders => _orders;
  OrderModel? get latestOrder => _latestOrder;
  bool get isLoadingHistory => _isLoadingHistory;
  String? get errorMessage => _errorMessage;

  OrderProvider({required this.orderRepository});

  void updateSelectedPaymentMethod(PaymentMethod method) {
    if (_selectedPaymentMethod == method) return;
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  String generateTransactionId() {
    return 'EVR-AAM-${DateTime.now().millisecondsSinceEpoch}';
  }

  ShippingAddressModel getInitialShippingAddress(UserModel? user) {
    if (user != null) {
      return ShippingAddressModel(
        fullName: user.fullName,
        addressLine: '742 Evergreen Terrace',
        city: 'Springfield',
        postalCode: '97477',
        phone: user.phone ?? '',
      );
    }
    return const ShippingAddressModel(
      fullName: 'Guest Shopper',
      addressLine: '100 Market Street',
      city: 'San Francisco',
      postalCode: '94105',
      phone: '+1 (555) 432-1098',
    );
  }

    void setGatewayLoading(bool loading) {
    _isGatewayLoading = loading;
    notifyListeners();
  }

  void resetCheckoutState() {
    _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
    _isGatewayLoading = false;
    _isSubmitting = false;
    _errorMessage = null;
    notifyListeners();
  }

  /*   Future<OrderModel?> placeOrder({
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
  } */

  Future<OrderModel?> placeOrder({
    required List<CartItem> items,
    required double subtotal,
    required double tax,
    required double total,
    required ShippingAddressModel shippingAddress,
    String? paymentMethod,
    String? paymentStatus,
    String? transactionId,
    UserModel? user,
  }) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final orderId =
          'EVR-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(900) + 100}';
      final newOrder = OrderModel(
        id: orderId,
        userId: user?.id ?? 0,
        items: List.from(items),
        subtotal: subtotal,
        tax: tax,
        total: total,
        shippingAddress: shippingAddress,
        paymentMethod: paymentMethod!,
        paymentStatus: paymentStatus,
        transactionId: transactionId,
        status: 'confirmed',
        createdAt: DateTime.now(),
      );

      final placed = await orderRepository.placeOrder(newOrder);
      _latestOrder = placed;
      // _orders.insert(0, placed);
      _isSubmitting = false;
      notifyListeners();
      return placed;
    } catch (e) {
      _errorMessage = e.toString();
      _isSubmitting = false;
      notifyListeners();
      return null;
    }
  }
}
