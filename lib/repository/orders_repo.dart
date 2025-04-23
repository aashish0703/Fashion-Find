import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/model/orders_model.dart';
import 'package:fashion_find/model/user_model.dart';


class OrdersRepo {

  Future<void> addOrder(String userId) async {
    final cartRef = FirebaseFirestore.instance.collection("cart").doc(userId).collection("items");
    final orderRef = FirebaseFirestore.instance.collection("orders");

    final cartSnapshot = await cartRef.get();

    if(cartSnapshot.docs.isEmpty) {
      throw Exception("No Item in cart");
    }

    double totalAmount = 0.0;
    List<Map<String, dynamic>> orderList = [];


    for(var doc in cartSnapshot.docs) {
      final item  = doc.data();
      totalAmount += item["price"]* item["quantity"];
      orderList.add(item);
    }

    final docRef = await orderRef.add({
      "id" : "",
      "userId" : userId,
      "items": orderList,
      "totalAmount": totalAmount,
      "status": "Pending",
      "createdAt": FieldValue.serverTimestamp()
    });

    await docRef.update({"id" : docRef.id});

    clearCart(userId);
  }

  Future<void> clearCart(String userId) async {
    final cartRef = FirebaseFirestore.instance.collection("cart").doc(userId).collection("items");
    final cartSnapshot = await cartRef.get();

    for(var doc in cartSnapshot.docs) {
      await cartRef.doc(doc.id).delete();
    }
  }

  Future<List<OrdersModel>> fetchLatestOrder(String userId) async {
    final query = FirebaseFirestore.instance
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .orderBy("createdAt", descending: true)
        .limit(1);

    final docRef = await query.get();

    return docRef.docs.map((doc) => OrdersModel.fromDocument(doc)).toList();
  }

  Future<List<OrdersModel>> fetchOrder(String userId) async {
    final docRef = FirebaseFirestore.instance.collection("orders").where("userId", isEqualTo: userId);

    final querySnapshot = await docRef.get();

    return querySnapshot.docs.map((doc) => OrdersModel.fromDocument(doc)).toList();
  }

  Future<AppUser> fetchCurrentUser(String userId) async {
    final docRef = FirebaseFirestore.instance.collection("users").doc(userId);
    final docSnapshot = await docRef.get();

    return AppUser.fromJson(docSnapshot.data()!);
  }
}