import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../models/order_model.dart';

@lazySingleton
class OrderRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Dio _dio = Dio();

  Future<void> placeOrder({
    required String userId,
    required String userEmail,
    required List<CartItemModel> items,
    required double totalPrice,
  }) async {
    final orderRef = _firestore.collection('orders').doc();

    final order = OrderModel(
      id: orderRef.id,
      userId: userId,
      userEmail: userEmail,
      items: items.map(OrderModel.itemToJson).toList(),
      totalPrice: totalPrice,
      status: 'pending',
      createdAt: DateTime.now(),
    );

    // Save order to Firestore
    await orderRef.set(order.toJson());

    // Notify N8N — fire and forget, don't block checkout on failure
    _notifyN8N(userEmail: userEmail, items: items, totalPrice: totalPrice);
  }

  void _notifyN8N({
    required String userEmail,
    required List<CartItemModel> items,
    required double totalPrice,
  }) {
    _dio
        .post(
      'https://khalednatey.app.n8n.cloud/webhook/order-placed',
      data: {
        'email': userEmail,
        'totalPrice': totalPrice,
        'itemCount': items.length,
        'items': items.map(OrderModel.itemToJson).toList(),
      },
    )
        .catchError((_) {}); // silently ignore network errors
  }
}