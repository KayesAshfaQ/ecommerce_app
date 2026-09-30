import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../repository/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository cartRepository;
  final bool autoLoad;

  List<CartItem> _items = [];
  bool _isLoading = false;

  CartProvider({
    required this.cartRepository,
    this.autoLoad = true,
  }) {
    if (autoLoad) {
      _loadInitialCart();
    }
  }

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;

  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (total, item) => total + item.totalPrice);

  double get tax => subtotal * 0.08; // 8% estimated tax

  double get total => subtotal + tax;

  Future<void> _loadInitialCart() async {
    _isLoading = true;
    notifyListeners();
    try {
      _items = await cartRepository.loadCart();
    } catch (_) {
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(CartItem item, {int? quantity}) async {
    final addQuantity = quantity ?? item.quantity;
    final index =
        _items.indexWhere((existingItem) => existingItem.product.id == item.product.id);
    if (index >= 0) {
      final existing = _items[index];
      _items[index] = existing.copyWith(quantity: existing.quantity + addQuantity);
    } else {
      _items.add(item.copyWith(quantity: addQuantity));
    }
    notifyListeners();
    await cartRepository.saveCart(_items);
  }

  Future<void> updateQuantity(int productId, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(productId);
      return;
    }

    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      notifyListeners();
      await cartRepository.saveCart(_items);
    }
  }

  Future<void> removeItem(int productId) async {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
    await cartRepository.saveCart(_items);
  }

  Future<void> clearCart() async {
    _items.clear();
    notifyListeners();
    await cartRepository.clearCart();
  }
}
