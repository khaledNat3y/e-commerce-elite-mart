import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../products/data/models/product_model.dart';
import '../data/models/cart_item_model.dart';
import 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartUpdated([]));

  List<CartItemModel> get _items =>
      state is CartUpdated ? (state as CartUpdated).items : [];

  void addItem(ProductModel product) {
    final current = List<CartItemModel>.from(_items);
    final index = current.indexWhere((i) => i.product.id == product.id);

    if (index >= 0) {
      current[index] = current[index].copyWith(
        quantity: current[index].quantity + 1,
      );
    } else {
      current.add(CartItemModel(product: product, quantity: 1));
    }

    emit(CartUpdated(current));
  }

  // ── Remove item ───────────────────────────────────────────────────────────
  void removeItem(String productId) {
    final current = List<CartItemModel>.from(_items)
      ..removeWhere((i) => i.product.id == productId);
    emit(CartUpdated(current));
  }

  // ── Increment quantity ────────────────────────────────────────────────────
  void increment(String productId) {
    final current = List<CartItemModel>.from(_items);
    final index = current.indexWhere((i) => i.product.id == productId);
    if (index < 0) return;
    current[index] = current[index].copyWith(
      quantity: current[index].quantity + 1,
    );
    emit(CartUpdated(current));
  }

  // ── Decrement quantity ────────────────────────────────────────────────────
  void decrement(String productId) {
    final current = List<CartItemModel>.from(_items);
    final index = current.indexWhere((i) => i.product.id == productId);
    if (index < 0) return;

    if (current[index].quantity == 1) {
      current.removeAt(index);
    } else {
      current[index] = current[index].copyWith(
        quantity: current[index].quantity - 1,
      );
    }
    emit(CartUpdated(current));
  }

  // ── Clear cart ────────────────────────────────────────────────────────────
  void clear() => emit(const CartUpdated([]));
}