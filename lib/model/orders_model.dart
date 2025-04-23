import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';

class OrdersModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  OrdersModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt
  });

  factory OrdersModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrdersModel(
      id: doc.id,
      userId: data['userId'],
      items: (data['items'] as List)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      totalAmount: (data['totalAmount'] as num).toDouble(),
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}