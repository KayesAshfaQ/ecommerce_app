import 'package:ecommerce_app/features/cart/provider/cart_provider.dart';
import 'package:ecommerce_app/features/cart/data/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/storage/preference_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/auth_remote_datasource.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/provider/auth_provider.dart';
import 'features/cart/data/cart_remote_datasource.dart';
import 'features/product/data/product_repository.dart';
import 'features/product/provider/product_provider.dart';

class MyApp extends StatelessWidget {
  final DioClient dioClient;
  final PreferenceService preferenceService;

  const MyApp({
    super.key,
    required this.dioClient,
    required this.preferenceService,
  });

  @override
  Widget build(BuildContext context) {
    final cachedUser = preferenceService.getUserData();
    final initialUserId = (cachedUser?['id'] as num?)?.toInt() ?? 1;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            authRepository: AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(dioClient: dioClient),
              preferenceService: preferenceService,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            productRepository: ProductRepositoryImpl(dioClient: dioClient),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(
            cartRepository: CartRepositoryImpl(
              preferenceService: preferenceService,
              remoteDatasource: CartRemoteDatasourceImpl(dioClient: dioClient),
            ),
            initialUserId: initialUserId,
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
