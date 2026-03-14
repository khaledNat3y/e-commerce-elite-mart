import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../cart/data/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String userEmail;
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final String status;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  static Map<String, dynamic> itemToJson(CartItemModel item) => {
    'productId': item.product.id,
    'name': item.product.name,
    'price': item.product.price,
    'quantity': item.quantity,
    'totalPrice': item.totalPrice,
  };

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userEmail': userEmail,
    'items': items,
    'totalPrice': totalPrice,
    'status': status,
    'createdAt': Timestamp.fromDate(createdAt),
  };
}