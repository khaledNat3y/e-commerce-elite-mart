// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_commerce_with_n8n_shopify/features/auth/data/repos/auth_repo.dart'
    as _i152;
import 'package:e_commerce_with_n8n_shopify/features/auth/logic/auth_cubit.dart'
    as _i229;
import 'package:e_commerce_with_n8n_shopify/features/cart/logic/cart_cubit.dart'
    as _i599;
import 'package:e_commerce_with_n8n_shopify/features/orders/data/repos/order_repo.dart'
    as _i806;
import 'package:e_commerce_with_n8n_shopify/features/orders/logic/order_cubit.dart'
    as _i47;
import 'package:e_commerce_with_n8n_shopify/features/products/data/repos/product_repo.dart'
    as _i108;
import 'package:e_commerce_with_n8n_shopify/features/products/logic/product_cubit.dart'
    as _i602;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i152.AuthRepo>(() => _i152.AuthRepo());
    gh.lazySingleton<_i599.CartCubit>(() => _i599.CartCubit());
    gh.lazySingleton<_i806.OrderRepo>(() => _i806.OrderRepo());
    gh.lazySingleton<_i108.ProductRepo>(() => _i108.ProductRepo());
    gh.factory<_i229.AuthCubit>(() => _i229.AuthCubit(gh<_i152.AuthRepo>()));
    gh.factory<_i602.ProductCubit>(
      () => _i602.ProductCubit(gh<_i108.ProductRepo>()),
    );
    gh.factory<_i47.OrderCubit>(() => _i47.OrderCubit(gh<_i806.OrderRepo>()));
    return this;
  }
}
