import 'package:e_commerce_with_n8n_shopify/core/router/routes.dart';
import 'package:e_commerce_with_n8n_shopify/features/auth/data/repos/auth_repo.dart';
import 'package:e_commerce_with_n8n_shopify/features/cart/presentation/views/cart_view.dart';
import 'package:e_commerce_with_n8n_shopify/features/products/presentation/views/product_view.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../di/injection.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation:AppRoutes.login,
    redirect: (context, state) {
      final isLoggedIn = getIt<AuthRepo>().isLoggedIn;
      final location = state.matchedLocation;

      final isOnAuthRoute =
          location == AppRoutes.login || location == AppRoutes.register;

      // Not logged in and trying to access a protected route → send to login
      if (!isLoggedIn && !isOnAuthRoute) return AppRoutes.login;

      // Already logged in and trying to access login/register → send to products
      if (isLoggedIn && isOnAuthRoute) return AppRoutes.products;

      return null; // No redirect needed
    },
    routes: [
      GoRoute(path: AppRoutes.login, name: AppRoutes.login,builder: (_, _) => const LoginView()),
      GoRoute(path: AppRoutes.register, name: AppRoutes.register, builder: (_, _) => const RegisterView()),
      GoRoute(path: AppRoutes.products, name: AppRoutes.products, builder: (_, _) => const ProductsView()),
      GoRoute(path: AppRoutes.cart, name: AppRoutes.cart, builder: (_, _) => const CartView()),
    ],
  );
}