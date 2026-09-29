import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();

  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3001';
    }
    return 'http://localhost:3001';
  }

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Endpoints
  static const String products = '/products';
  static const String productCategories = '/products/categories';
  static const String productCategoryPrefix = '/products/category';
  static const String productSearch = '/products/search';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String cachedProductsKey = 'cached_products_list';
  static const String cachedCartKey = 'cached_cart_items';
  static const String favoriteProductIdsKey = 'favorite_product_ids';
}
