

import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String id;
  String productId;
  String productName;
  double price;
  int quantity;
  int stockAvailable;
  String imageUrl;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.stockAvailable,
    required this.imageUrl,
  });

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'stockAvailable': stockAvailable,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      productId: map['productId'],
      productName: map['productName'],
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'],
      stockAvailable: map['stockAvailable'],
      imageUrl: map['imageUrl'],
    );
  }

  // Factory constructor to create object from Firestore document
  factory CartItem.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItem(
      id: doc.id,
      productId: data['productId'],
      productName: data['productName'],
      price: (data['price'] as num).toDouble(),
      quantity: data['quantity'] as int,
      stockAvailable: data['stockAvailable'] as int,
      imageUrl: data['imageUrl'] as String,
    );
  }
}





// class ShoppingCartModel {
//   final String userId;
//   final String cartId;
//   List<ProductItem> productItems;
//
//   ShoppingCartModel({required this.userId, required this.cartId, required this.productItems});
//
//   factory ShoppingCartModel.fromJson(Map<String, dynamic> json) {
//
//     List<ProductItem> productItems = [];
//     json["productItems"].forEach((item) {
//       productItems.add(ProductItem.fromJson(item));
//     });
//
//     return ShoppingCartModel(
//         userId: json["userId"],
//         cartId: json["cartId"],
//         productItems: productItems
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "userId": userId,
//       "cartId" : cartId,
//       "productItems" :  productItems.map((item) => item.toJson()).toList()
//     };
//   }
// }

// class ProductItem {
//   final String productId;
//   final String productImage;
//   final String productName;
//   final double productPrice;
//   final double productSellingPrice;
//   final int productQuantity;
//
//   ProductItem({
//     required this.productId,
//     required this.productImage,
//     required this.productName,
//     required this.productPrice,
//     required this.productSellingPrice,
//     required this.productQuantity
//   });
//
//   factory ProductItem.fromJson(Map<String, dynamic> json) {
//     return ProductItem(
//         productId: json["productId"],
//         productImage: json["productImage"],
//         productName: json["productName"],
//         productPrice: (json["productPrice"] as num).toDouble(),
//         productSellingPrice: (json["productSellingPrice"] as num).toDouble(),
//         productQuantity: json["productQuantity"] ?? 1
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "productId": productId,
//       "productImage": productImage,
//       "productName": productName,
//       "productPrice" : productPrice,
//       "productSellingPrice" : productSellingPrice,
//       "productQuantity" : productQuantity
//     };
//   }
// }








// class ShoppingCartModel {
//   final String userId;
//   final String cartId;
//   final List<String> productId;
//   final int quantity;
//   final double totalCartValue;
//
//   ShoppingCartModel({required this.userId, required this.cartId, required this.productId, required this.quantity, required this.totalCartValue});
//
//   factory ShoppingCartModel.fromJson(Map<String, dynamic> data) {
//     final productIdFromJson = data["productId"];
//     List<String> productIdList = productIdFromJson.cast<String>();
//     return ShoppingCartModel(
//         userId: data["userId"],
//         cartId: data["cartId"],
//       productId: productIdList,
//       quantity: data["quantity"] as int,
//       totalCartValue: data["totalCartValue"] as double
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "userId" : userId,
//       "cartId" : cartId,
//       "productId" : productId,
//       "quantity" : quantity,
//       "totalCartValue" : totalCartValue
//     };
//   }
// }