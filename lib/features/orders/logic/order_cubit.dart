import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../cart/data/models/cart_item_model.dart';
import '../data/repos/order_repo.dart';
import 'order_state.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;

  OrderCubit(this._orderRepo) : super(OrderInitial());

  Future<void> placeOrder(List<CartItemModel> items, double totalPrice) async {
    emit(OrderLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const OrderFailure('You must be logged in to place an order.'));
        return;
      }

      await _orderRepo.placeOrder(
        userId: user.uid,
        userEmail: user.email ?? '',
        items: items,
        totalPrice: totalPrice,
      );

      emit(OrderSuccess());
    } on Exception catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}