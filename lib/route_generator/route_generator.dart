
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_event.dart';
import 'package:fashion_find/model/category_model.dart';
import 'package:fashion_find/model/product_model.dart';
import 'package:fashion_find/model/sub_subcategory_model.dart';
import 'package:fashion_find/model/subcategory_model.dart';
import 'package:fashion_find/views/add_address_page.dart';
import 'package:fashion_find/views/all_orders_page.dart';
import 'package:fashion_find/views/category_detail/category_detail.dart';
import 'package:fashion_find/views/checkout_page/checkout_page.dart';
import 'package:fashion_find/views/edit_user_profile.dart';
import 'package:fashion_find/views/forgot_password.dart';
import 'package:fashion_find/views/help_center_page.dart';
import 'package:fashion_find/views/landing_page.dart';
import 'package:fashion_find/views/login_page.dart';
import 'package:fashion_find/views/notifications_page.dart';
import 'package:fashion_find/views/on_boarding_page.dart';
import 'package:fashion_find/views/product_details_page.dart';
import 'package:fashion_find/views/product_page/products_page.dart';
import 'package:fashion_find/views/shopping_cart/shopping_cart_page.dart';
import 'package:fashion_find/views/show_address_page.dart';
import 'package:fashion_find/views/show_subsubcategory_page.dart';
import 'package:fashion_find/views/splash_page.dart';
import 'package:fashion_find/views/user_account_page.dart';
import 'package:fashion_find/views/wishlist_page.dart';

import 'package:flutter/material.dart';

import '../views/home/home_page.dart';
import '../views/registration_page.dart';

class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final arguments = settings.arguments;

    switch(settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case "/onBoardingPage":
        return MaterialPageRoute(builder: (context) => const OnBoardingPage());
      case "/loginPage":
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case "/registrationPage":
        return MaterialPageRoute(builder: (context) => const RegistrationPage());
      case "/forgotPassword":
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case "/landingPage":
        return MaterialPageRoute(builder: (context) => const LandingPage());
      case "/homePage":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case "/categoryDetail":
        return MaterialPageRoute(builder: (context) => CategoryDetail(categoryData: arguments as Category,));
      case "/showSubSubcategoryPage":
        return MaterialPageRoute(builder: (context) => ShowSubsubcategoryPage(subCategoryData: arguments as SubcategoryModel));
      case "/productsPage":
        return MaterialPageRoute(builder: (context) => ProductsPage(name:  arguments as String?));
      case "/productDetailsPage":
        return MaterialPageRoute(builder: (context) => ProductDetailsPage(productDetails: arguments as ProductModel));
      case "/wishlistPage":
        return MaterialPageRoute(builder: (context) => const WishlistPage());
      case "/shoppingCartPage":
        return MaterialPageRoute(builder: (context) => const ShoppingCartPage());
      case "/checkoutPage":
        return MaterialPageRoute(builder: (context) => const CheckoutPage());
      case "/userAccountPage":
        return MaterialPageRoute(builder: (context) => const UserAccountPage());
      case "/helpCenterPage":
        return MaterialPageRoute(builder: (context) => const HelpCenterPage());
      case "/notificationsPage":
        return MaterialPageRoute(builder: (context) => const NotificationsPage());
      case "/editUserProfilePage":
        return MaterialPageRoute(builder: (context) => const EditUserProfile());
      case "/showAddressPage":
        return MaterialPageRoute(builder: (context) => const ShowAddressPage());
      case "/addAddressPage":
        return MaterialPageRoute(builder: (context) => const AddAddressPage());
      case "/allOrdersPage":
        return MaterialPageRoute(builder: (context) => const AllOrdersPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("No Page Found", style: Theme.of(context).textTheme.headlineLarge,),
        ),
      );
    });
  }
}