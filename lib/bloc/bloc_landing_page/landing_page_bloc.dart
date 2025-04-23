import 'package:fashion_find/bloc/bloc_landing_page/landing_page_event.dart';
import 'package:fashion_find/bloc/bloc_landing_page/landing_page_state.dart';
import 'package:fashion_find/views/home/home_page.dart';
import 'package:fashion_find/views/shopping_cart/shopping_cart_page.dart';
import 'package:fashion_find/views/user_account_page.dart';
import 'package:fashion_find/views/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  
  List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
      label: "Home",
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_rounded),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        label: "Cart"
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: "Profile"
    ),
  ];

  List<Widget> bottomNavScreen = <Widget> [
    const HomePage(),
    const WishlistPage(),
    const ShoppingCartPage(),
    const UserAccountPage(),
  ];
  
  
  LandingPageBloc() : super(LandingPageInitialState(tabIndex: 0)) {
   on<TabChangeEvent>((event, emit) {
     emit(LandingPageInitialState(tabIndex: event.tabIndex));
   });

   on<ResetIndexEvent>((event, emit) {
     emit(LandingPageInitialState(tabIndex: 0));
   });
  }
}