import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/product/presentation/pages/product_details.dart';

class AppRouter {
  AppRouter._();

  static const String homePath = '/';
  static const String productDetailPath = '/products/:id';
  static const String cartPath = '/cart';

  static String productDetailRoute(int id) => '/products/$id';

  static final GoRouter router = GoRouter(
    initialLocation: productDetailPath,
    routes: [
      GoRoute(
        path: homePath,
        name: 'home',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Products Catalog'))),
      ),
      GoRoute(
        path: productDetailPath,
        name: 'productDetail',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ProductDetailScreen(productId: int.tryParse(id) ?? 0);
        },
      ),
      GoRoute(
        path: cartPath,
        name: 'cart',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('My Cart')),
          body: const Center(child: Text('Shopping Cart')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),
              const Text(
                '404 - Page Not Found',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'The route "${state.uri.path}" could not be found.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Back to Catalog'),
                onPressed: () => context.go(homePath),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
