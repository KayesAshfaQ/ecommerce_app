import '../../../core/storage/preference_service.dart';
import '../models/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> loadCart();
  Future<void> saveCart(List<CartItem> items);
  Future<void> clearCart();
}

class CartRepositoryImpl implements CartRepository {
  final PreferenceService preferenceService;

  CartRepositoryImpl({required this.preferenceService});

  @override
  Future<List<CartItem>> loadCart() async {
    final cached = preferenceService.getCartCache();
    return cached.map((e) => CartItem.fromJson(e)).toList();
  }

  @override
  Future<void> saveCart(List<CartItem> items) async {
    final maps = items.map((e) => e.toJson()).toList();
    await preferenceService.setCartCache(maps);
  }

  @override
  Future<void> clearCart() async {
    await preferenceService.setCartCache([]);
  }
}
