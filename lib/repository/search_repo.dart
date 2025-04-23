import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/model/product_model.dart';

class SearchRepo {

  Future<List<ProductModel>> getSearchResult(String searchQuery) async {
    final query = FirebaseFirestore.instance
        .collection("products")
        .where("productName", isGreaterThanOrEqualTo: searchQuery)
        .where("productName", isLessThanOrEqualTo: '$searchQuery\uf8ff');

    final querySnapshot = await query.get();

    final productList = querySnapshot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();

    return productList;
  }

}