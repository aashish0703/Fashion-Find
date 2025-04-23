import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/bloc/bloc_wishlist_page/wishlist_page_event.dart';
import 'package:fashion_find/bloc/bloc_wishlist_page/wishlist_page_state.dart';
import 'package:fashion_find/model/product_model.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListPageBloc extends Bloc<WishListPageEvent, WishListPageState> {

  Future<List<ProductModel>> loadWishList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("wishList") ?? [];
    print("[loadWishList] list: $list");

    List<ProductModel> products = [];

    if(list.isEmpty) {
      return products;
    } else {
      for(String id in list) {
        final docSnapshot = await FirebaseFirestore.instance.collection("products").doc(id).get();

        if(docSnapshot.exists) {
          products.add(ProductModel.fromJson(docSnapshot.data() as Map<String, dynamic>));
        }
      }
      return products;
    }
  }


  final _firebaseRepo = FirebaseRepo();

  WishListPageBloc() : super(WishListPageInitialState()) {
    on<LoadWishListPage>((event, emit) async {
      emit(WishListPageLoadingState());

      try {
        final List<ProductModel> products = await loadWishList();
        if(products.isEmpty) {
          emit(WishListPageLoadedState(productDetails: const []));
        } else {
          emit(WishListPageLoadedState(productDetails: products));
        }
      } catch (e) {
        emit(WishListPageErrorState(errorMessage: e.toString()));
      }

      // try {
      //   final List<String> wishList = await loadWishList();
      //   print(wishList);
      //
      //   if(wishList.isEmpty) {
      //     emit(WishListPageErrorState(errorMessage: "WishList is empty"));
      //   } else {
      //     Stream<QuerySnapshot<Map<String, dynamic>>> productDetails;
      //
      //     for(String id in wishList) {
      //       productDetails = await _firebaseRepo.getProductWithProductId(id);
      //       if(await productDetails.isEmpty) {
      //         emit(WishListPageErrorState(errorMessage: "[WishListPageBloc]ProductDetails empty"));
      //       } else {
      //         emit(WishListPageLoadedState(productDetails: productDetails));
      //       }
      //     }
      //   }
      //
      //
      //   // final productDetails = await _firebaseRepo.getProductWithProductId(event.productId);
      //   // if(await productDetails.isEmpty) {
      //   //   emit(WishListPageErrorState(errorMessage: "[WishListPageBloc]ProductDetails empty"));
      //   // } else {
      //   //   emit(WishListPageLoadedState(productDetails: productDetails));
      //   // }
      //   } catch (e) {
      //   emit(WishListPageErrorState(errorMessage: e.toString()));
      // }
    });
  }
}