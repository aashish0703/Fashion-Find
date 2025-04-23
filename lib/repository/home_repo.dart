import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeRepo {

  final db = FirebaseFirestore.instance.collection("category");

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getProducts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("products");
    final productRef = await docRef.where("subsubcategoryId", isEqualTo: "ssc-mtwtshirts-03").snapshots();

    return productRef;
  }
  
  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() {
    try {
       return db.get();
    } catch (e) {
      print("[getCategories] error: $e");
      throw Exception(e.toString());
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getBanners() async {
    final banners = FirebaseFirestore.instance.collection("banners").snapshots();
    return banners;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getSubCategories(String categoryId) async {
    final subCategories = FirebaseFirestore.instance
        .collection("subcategory")
        .where("categoryId", isEqualTo: categoryId)
        .snapshots();

    return subCategories;
  }
  
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getSubSubCategories(String subcategoryId) async {
    final subSubCategories = FirebaseFirestore.instance
        .collection("subsubcategory")
        .where("subcategoryId", isEqualTo: subcategoryId)
        .snapshots();

    return subSubCategories;
  }
}