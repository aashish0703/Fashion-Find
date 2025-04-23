import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/model/orders_model.dart';
import 'package:fashion_find/model/product_model.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';
import 'package:fashion_find/model/user_model.dart';
import 'package:fashion_find/repository/forgot_password_repo.dart';
import 'package:fashion_find/repository/home_repo.dart';
import 'package:fashion_find/repository/login_repo.dart';
import 'package:fashion_find/repository/orders_repo.dart';
import 'package:fashion_find/repository/product_repo.dart';
import 'package:fashion_find/repository/registration_repo.dart';
import 'package:fashion_find/repository/search_repo.dart';
import 'package:fashion_find/repository/shopping_cart_repo.dart';
import 'package:fashion_find/repository/user_account_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepo {

  final _loginRepo = LoginRepo();
  final _registrationRepo = RegistrationRepo();
  final _forgotPasswordRepo = ForgotPasswordRepo();
  final _homeRepo = HomeRepo();
  final _productRepo = ProductRepo();
  final _userAccountRepo = UserAccountRepo();
  final _shoppingCartRepo = ShoppingCartRepo();
  final _ordersRepo = OrdersRepo();
  final _searchRepo = SearchRepo();


  // *********************AUTHENTICATION FUNCTIONS*********************

  Future<User?> login(String email, String password) async {
    return await _loginRepo.login(email, password);
  }

  Future<UserCredential> signInWithGoogle() async {
    return await _loginRepo.signInWithGoogle();
  }

  Future<void> register(String name, String email, String password, String contact, String primaryAddress) async {
    return await _registrationRepo.register(name, email, password, contact, primaryAddress);
  }

  Future<void> forgotPassword(String email) async {
    return await _forgotPasswordRepo.forgotPassword(email);
  }


  // ******************* ORDERS FUNCTIONS ********************

  Future<void> addOrder(String userId) async {
    return await _ordersRepo.addOrder(userId);
  }

  Future<List<OrdersModel>> fetchOrder(String userId) async {
    return await _ordersRepo.fetchOrder(userId);
  }

  Future<List<OrdersModel>> fetchLatestOrder(String userId) async {
    return await _ordersRepo.fetchLatestOrder(userId);
  }

  Future<AppUser> fetchCurrentUser(String userId) async {
    return _ordersRepo.fetchCurrentUser(userId);
  }

  // ******************* SEARCH FUNCTION *********************

  Future<List<ProductModel>> getSearchResult(String searchQuery) async {
    return _searchRepo.getSearchResult(searchQuery);
  }

  // ******************* SHOPPING CART FUNCTIONS ********************


  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchCartItems(String userId) async {
    return _shoppingCartRepo.fetchCartItems(userId);
  }

  Future<void> addProductToCart(String userId, CartItem item) async {
    return _shoppingCartRepo.addProductToCart(userId, item);
  }

  Future<void> removeProductFromCart(String userId, String cartItemId) async {
    return await _shoppingCartRepo.removeProductFromCart(userId, cartItemId);
  }

  Future<void> increaseQuantity(String userId, String cartItemId) async {
    return await _shoppingCartRepo.increaseQuantity(userId, cartItemId);
  }

  Future<void> decreaseQuantity(String userId, String cartItemId) async {
    return await _shoppingCartRepo.decreaseQuantity(userId, cartItemId);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> loadProductsWithId(String productId) async {
    return await _shoppingCartRepo.loadProductsWithId(productId);
  }



  // ******************* HOME PAGE FUNCTIONS *******************

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getProducts() async {
    return await _homeRepo.getProducts();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() async {
    return await _homeRepo.getCategories();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getBanners() async {
    return await _homeRepo.getBanners();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getSubCategories(String categoryId) async {
    return await _homeRepo.getSubCategories(categoryId);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getSubSubCategories(String subcategoryId) async {
    return await _homeRepo.getSubSubCategories(subcategoryId);
  }

  // ***********PRODUCT RETRIEVAL FUNCTIONS*****************

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getProductsWithSubSubCategory(String subSubcategoryId) async {
    return await _productRepo.getProductsWithSubSubCategory(subSubcategoryId);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getProductWithProductId(String productId) async {
    return await _productRepo.getProductWithProductId(productId);
  }

  // ***********USER FUNCTIONS*********************

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUserDetail(String uid) async {
    return await _userAccountRepo.getUserDetail(uid);
  }

  Future<void> updateUser(String name, String contact, String gender, String primaryAddress) async {
    return await _userAccountRepo.updateUser(name, contact, gender, primaryAddress);
  }

  Future<void> deleteUser(String uid) async {
    return await _userAccountRepo.deleteUser(uid);
  }

  Future<void> addAddress(String uid, String address) async {
    return await _userAccountRepo.addAddress(uid, address);
  }

  Future<void> removeAddress(String uid, String address) async {
    return await _userAccountRepo.removeAddress(uid, address);
  }

  Future<void> removePrimaryAddress(String uid) async {
    return await _userAccountRepo.removePrimaryAddress(uid);
  }
}