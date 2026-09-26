import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/product/data/product_repository.dart';
import 'features/product/provider/product_provider.dart';

class MyApp extends StatelessWidget {
  final DioClient dioClient;

  const MyApp({super.key, required this.dioClient});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            productRepository: ProductRepositoryImpl(dioClient: dioClient),
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
