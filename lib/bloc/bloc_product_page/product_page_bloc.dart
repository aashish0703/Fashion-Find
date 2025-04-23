import 'package:fashion_find/bloc/bloc_product_page/product_page_event.dart';
import 'package:fashion_find/bloc/bloc_product_page/product_page_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPageBloc extends Bloc<ProductPageEvent, ProductPageState> {

  ValueNotifier<bool> isSelected = ValueNotifier(false);

  void selectedOption(bool value) {
    isSelected.value = value;
  }

  int calculateDiscount(double price, double sellingPrice) {
    return ((price - sellingPrice)/price * 100).toInt();
  }

  Future<bool> isProductWishList(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final wishList =prefs.getStringList("wishList") ?? [];
    print("[isProductWishList] wishList.contains(productId) : ${wishList.contains(productId)}");
    return wishList.contains(productId);
  }

  void saveProductToWishList(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favouriteWishList = prefs.getStringList("wishList") ?? [];
    favouriteWishList.add(productId);
    print("[saveProductToWishList] wishList.length: ${favouriteWishList.length}");
    print("[saveProductToWishList] wishlist: $favouriteWishList");
    prefs.setStringList("wishList", favouriteWishList);
  }

  void removeProductFromWishList(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final wishList = prefs.getStringList("wishList") ?? [];
    if(wishList.isEmpty) {
      return;
    } else if((wishList.length == 1) && (wishList.first == productId)) {
      wishList.removeLast();
      prefs.setStringList("wishList", wishList);
      print("[removeProductFromWishList] wishList: $wishList");
    }else {
      wishList.removeWhere((item) => item == productId);
      prefs.setStringList("wishList", wishList);
      print("[removeProductFromWishList] wishList: $wishList");
      print("[removeProductFromWishList] wishList.length: ${wishList.length}");
    }
  }

  final _firebaseRepo = FirebaseRepo();

  ProductPageBloc() : super(ProductPageInitialState()) {
    on<LoadSubSubCategoryProductEvent>((event, emit) async {
      emit(ProductPageLoadingState());
      try {
        final productDetails = await _firebaseRepo.getProductsWithSubSubCategory(event.subSubcategoryId);
        if(await productDetails.isEmpty) {
          emit(ProductPageErrorState(errorMessage: "Something went wrong"));
        } else {
          emit(ProductPageLoadedState(subsubcategoryProductDetails: productDetails));
        }

      } catch (e) {
        emit(ProductPageErrorState(errorMessage: e.toString()));
      }
    });

  }
}