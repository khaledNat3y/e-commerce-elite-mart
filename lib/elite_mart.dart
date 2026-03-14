import 'package:e_commerce_with_n8n_shopify/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'features/cart/logic/cart_cubit.dart';
import 'features/products/logic/product_cubit.dart';

class EliteMart extends StatefulWidget {
  const EliteMart({super.key});

  @override
  State<EliteMart> createState() => _EliteMartState();
}

class _EliteMartState extends State<EliteMart> {
  late final CartCubit _cartCubit = CartCubit();
  late final ProductCubit _productCubit = getIt<ProductCubit>()..loadProducts();
  @override
  void dispose() {
    _cartCubit.close();
    _productCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>.value(value: _cartCubit),
        BlocProvider<ProductCubit>.value(value: _productCubit),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Elite Mart',
        routerConfig: AppRouter.router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
      ),
    );
  }
}