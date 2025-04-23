import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';
import 'package:fashion_find/util/util.dart';

class ShoppingCartRepo {
  final db = FirebaseFirestore.instance.collection("cart");

  // Future<String> createEmptyCart() async {
  //   try{
  //     final docRef = db.doc();
  //     print("[createEmptyCart] docRef.id: ${docRef.id}");
  //
  //     Util.cartId = docRef.id;
  //     print("[createEmptyCart] Util.cartId: ${Util.cartId}");
  //
  //     CartItem cartItem = CartItem(id: Util.cartId!, productId: productId, productName: productName, price: price, quantity: quantity, stockAvailable: stockAvailable, imageUrl: imageUrl)
  //
  //     Map<String, dynamic> data = cartModel.toJson();
  //     docRef.set(data);
  //
  //     return docRef.id;
  //
  //   } catch (e) {
  //     print("Error while creating shopping cart.");
  //     print("Error: ${e.toString()}");
  //     throw Exception(e.toString());
  //   }
  // }





  Future<QuerySnapshot<Map<String, dynamic>>> loadProductsWithId(String productId) async {

    final value = db.where("productId", isEqualTo: productId).get();

    return value;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCartItems(String userId) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db
        .collection("cart")
        .doc(userId)
        .collection("items")
        .snapshots();
        // .snapshots().map((snapshot) => snapshot.docs.map((doc) => CartItem.fromDocument(doc)).toList());
  }

  Future<void> addProductToCart(String userId, CartItem item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final cartRef = db.collection("cart").doc(userId).collection("items");
    final cartItem = await cartRef.where("productId", isEqualTo: item.productId).get();

    print("cartItem: $cartItem");
    print("cartItem.docs: ${cartItem.docs}");

    if(cartItem.docs.isNotEmpty) {
      final doc = cartItem.docs.first;
      final newQuantity = doc["quantity"];
      if(newQuantity >= doc["stockAvailable"]) {
        // final newQuantity = doc["quantity"] + item.quantity;
        return doc["quantity"];
      } else {
        await cartRef.doc(doc.id).update({'quantity': newQuantity + 1});
      }
    } else {
      final docRef = await cartRef.add(item.toJson());
      await docRef.update({"id" : docRef.id});
    }
  }

  Future<void> removeProductFromCart(String userId, String cartItemId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef =  db.collection("cart").doc(userId).collection("items").doc(cartItemId);
    return await docRef.delete();
  }

  Future<void> increaseQuantity(String userId, String cartItemId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      final docRef =
          db.collection("cart").doc(userId).collection("items").doc(cartItemId);

      final cartItemRef = await docRef.get();
      if (cartItemRef.exists) {
        final currentQuantity = cartItemRef["quantity"];
        if(currentQuantity >= cartItemRef["stockAvailable"]) {
          return await cartItemRef["quantity"];
        } else {
          return await docRef.update({"quantity": currentQuantity + 1});
        }
      }
    } catch(e) {
      print("[increaseQuantity] error while increasing quantity");
      print("[increaseQuantity] error: ${e.toString()}");
    }
  }

  Future<void> decreaseQuantity(String userId, String cartItemId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      final docRef =
          db.collection("cart").doc(userId).collection("items").doc(cartItemId);

      final cartItemRef = await docRef.get();
      if (cartItemRef.exists) {
        final currentQuantity = cartItemRef["quantity"];
        if (currentQuantity > 1) {
          await docRef.update({"quantity": currentQuantity - 1});
        } else {
          docRef.delete();
        }
      }
    } catch (e) {
      print("[decreaseQuantity] error while decreasing quantity");
      print("[decreaseQuantity] error: ${e.toString()}");
    }
  }
}


/*

  Future<ShoppingCartModel> loadCartDetails(String cartId) async {
    try {
      final cart = await db.doc(cartId).get();
      if(cart.exists) {

        final cartValue = ShoppingCartModel.fromJson(cart.data() as Map<String, dynamic>);

        return cartValue;
      }
      return ShoppingCartModel(userId: "", cartId: "", productItems: []);
    } catch(e) {
      print("[loadCartDetails] error while fetching cart details.");
      print("[loadCartDetails] error: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<List<ShoppingCartModel>> loadCartItems(String cartId) async {
    try {
      final cartItems = await db.doc(cartId).get();
      if(cartItems.exists) {
        List<ShoppingCartModel> cartItemsList = [];
        cartItemsList.add(ShoppingCartModel.fromJson(cartItems.data() as Map<String, dynamic>));

        return cartItemsList;
      }
      return [];
    } catch(e) {
          print("[loadCartItems] error while fetching cart items.");
          print("[loadCartItems] error: ${e.toString()}");
          throw Exception(e.toString());
    }
  }

Future<void> addProductToCart(String cartId, String productId, String productName, String productImage, double productPrice, double productSellingPrice) async {
    try {
      final docRef = db.doc(cartId);
      final ProductItem productItem = ProductItem(
          productId: productId,
          productImage: productImage,
          productName: productName,
          productPrice: productPrice,
          productSellingPrice: productSellingPrice,
          productQuantity: 1
      );
      docRef.update({
        "productItems" : FieldValue.arrayUnion([productItem.toJson()])
      });
    } catch (e) {
      print("Error while adding product to cart.");
      print("Error: ${e.toString()}");
    }
  }


Future<void> removeProductFromCart(String cartId, String productId) async {
    try {
      final docRef =  db.doc(cartId);
      final cartRef = await docRef.get();

      if(cartRef.exists) {
        final cartItem = ShoppingCartModel.fromJson(cartRef.data() as Map<String, dynamic>);
        print("[removeProductFromCart] cartItem : ${cartItem.productItems}");

        final productList = cartItem.productItems.toList();

        productList.removeWhere((id) => id.productId == productId);

        print("productList: $productList");

        docRef.update({
          "productItems" : FieldValue.arrayUnion([productList])
        });
      }

    } catch (e) {
      print("Error while removing product from cart.");
      print("Error: ${e.toString()}");
    }
  }
 */

/*
  // Future<List<ProductModel>> loadCartItems(String cartId) async {
  //   try {
  //     final cartItems = await db.doc(cartId).get();
  //
  //     if(cartItems.exists) {
  //       List<String> productIds = List<String>.from(cartItems["productItems"] ?? []);
  //
  //       List<ProductModel> productList = [];
  //
  //       for(String id in productIds) {
  //         final docSnapshot = await FirebaseFirestore.instance.collection("products").doc(id).get();
  //
  //         if(docSnapshot.exists) {
  //           productList.add(ProductModel.fromJson(docSnapshot.data() as Map<String, dynamic>));
  //         }
  //       }
  //
  //       return productList;
  //     }
  //
  //     return [];
  //   } catch (e) {
  //     print("[loadCartItems] error while fetching cart items.");
  //     print("[loadCartItems] error: ${e.toString()}");
  //     throw Exception(e.toString());
  //   }
  // }

 */