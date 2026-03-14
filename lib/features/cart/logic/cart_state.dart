import 'package:equatable/equatable.dart';
import '../data/models/cart_item_model.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartUpdated extends CartState {
  final List<CartItemModel> items;

  const CartUpdated(this.items);

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [items];
}