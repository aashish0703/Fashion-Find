import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepo {
  final db = FirebaseFirestore.instance.collection("products");

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getProductsWithSubSubCategory(String subSubcategoryId) async {
    final productList = db
        .where("subsubcategoryId", isEqualTo: subSubcategoryId)
        .snapshots();

    return productList;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getProductWithProductId(String productId) async {
    final productDetails = db
        .where("productId", isEqualTo: productId)
        .snapshots();

    return productDetails;
  }
}