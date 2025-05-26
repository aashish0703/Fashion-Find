import 'package:fashion_find/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fashion_find/bloc/bloc_add_address/add_address_bloc.dart';
import 'package:fashion_find/bloc/bloc_banners/banners_bloc.dart';
import 'package:fashion_find/bloc/bloc_categories/categories_bloc.dart';
import 'package:fashion_find/bloc/bloc_category_detail/category_detail_bloc.dart';
import 'package:fashion_find/bloc/bloc_edit_user_profile/edit_user_profile_bloc.dart';
import 'package:fashion_find/bloc/bloc_forgot_password/forgot_password_bloc.dart';
import 'package:fashion_find/bloc/bloc_home/home_bloc.dart';
import 'package:fashion_find/bloc/bloc_home_products/home_products_bloc.dart';
import 'package:fashion_find/bloc/bloc_landing_page/landing_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_login/login_bloc.dart';
import 'package:fashion_find/bloc/bloc_notifications/notifications_bloc.dart';
import 'package:fashion_find/bloc/bloc_orders/orders_bloc.dart';
import 'package:fashion_find/bloc/bloc_product_page/product_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_registration/registration_bloc.dart';
import 'package:fashion_find/bloc/bloc_search/search_bloc.dart';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_bloc.dart';
import 'package:fashion_find/bloc/bloc_sub_subcategories/sub_subcategory_bloc.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_wishlist_page/wishlist_page_bloc.dart';
import 'package:fashion_find/route_generator/route_generator.dart';
import 'package:fashion_find/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_show_address/show_address_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<RegistrationBloc>(create: (context) => RegistrationBloc()),
        BlocProvider<ForgotPasswordBloc>(create: (context) => ForgotPasswordBloc()),
        BlocProvider<LandingPageBloc>(create: (context) => LandingPageBloc()),
        BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
        BlocProvider<CategoriesBloc>(create: (context) => CategoriesBloc()),
        BlocProvider<BannersBloc>(create: (context) => BannersBloc()),
        BlocProvider<HomeProductsBloc>(create: (context) => HomeProductsBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<WishListPageBloc>(create: (context) => WishListPageBloc()),
        BlocProvider<SubSubCategoryBloc>(create: (context) => SubSubCategoryBloc()),
        BlocProvider<CategoryDetailBloc>(create: (context) => CategoryDetailBloc()),
        BlocProvider<ProductPageBloc>(create: (context) => ProductPageBloc()),
        BlocProvider<UserAccountPageBloc>(create: (context) => UserAccountPageBloc()),
        BlocProvider<NotificationsBloc>(create: (context) => NotificationsBloc()),
        BlocProvider<AddAddressBloc>(create: (context) => AddAddressBloc()),
        BlocProvider<EditUserProfileBloc>(create: (context) => EditUserProfileBloc()),
        BlocProvider<ShowAddressBloc>(create: (context) => ShowAddressBloc()),
        BlocProvider<ShoppingCartBloc>(create: (context) => ShoppingCartBloc()),
        BlocProvider<OrdersBloc>(create: (context) => OrdersBloc())
      ],
      child: MaterialApp(
        title: "Fashion Find",
        theme: buildThemeData(),
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoutes,
      ),
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(232, 187, 130 ,1)),
      fontFamily: "Poppins",
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(213, 172, 121, 1),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        )
      ),
      textTheme: const TextTheme(
        displayMedium: TextStyle(fontSize: 45, fontFamily: "Poppins", fontWeight: FontWeight.w500, color: Color.fromRGBO(213, 172, 121, 1)),
        headlineLarge: TextStyle(fontSize: 32, fontFamily: "Poppins", fontWeight: FontWeight.w500, color: Color.fromRGBO(213, 172, 121, 1)),
        headlineMedium: TextStyle(fontSize: 28, fontFamily: "Poppins", fontWeight: FontWeight.w500, color: Color.fromRGBO(213, 172, 121, 1)),
        titleLarge: TextStyle(fontSize: 22, fontFamily: "Poppins", fontWeight: FontWeight.w400),
        titleMedium: TextStyle(fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14, fontFamily: "Poppins", fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 14, fontFamily: "Poppins", fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w400),
      ),
      useMaterial3: true,
    );
  }
}
