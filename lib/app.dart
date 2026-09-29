import 'package:ecommerce_app/features/cart/provider/cart_provider.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/storage/preference_service.dart';
import 'core/theme/app_theme.dart';
import 'features/product/data/product_repository.dart';
import 'features/product/provider/product_provider.dart';

class MyApp extends StatelessWidget {
  final DioClient dioClient;
  final PreferenceService preferenceService;

  const MyApp({super.key, required this.dioClient, required this.preferenceService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            productRepository: ProductRepositoryImpl(dioClient: dioClient),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>  CartProvider(
            cartRepository: CartRepositoryImpl(preferenceService: preferenceService),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
