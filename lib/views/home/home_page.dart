
import 'package:fashion_find/bloc/bloc_banners/banners_bloc.dart';
import 'package:fashion_find/bloc/bloc_banners/banners_event.dart';
import 'package:fashion_find/bloc/bloc_categories/categories_bloc.dart';
import 'package:fashion_find/bloc/bloc_categories/categories_event.dart';
import 'package:fashion_find/bloc/bloc_home_products/home_products_bloc.dart';
import 'package:fashion_find/bloc/bloc_home_products/home_products_event.dart';
import 'package:fashion_find/util/widgets/custom_button.dart';
import 'package:fashion_find/views/home/widgets/banners_widget.dart';
import 'package:fashion_find/views/home/widgets/category_widget.dart';
import 'package:fashion_find/views/home/widgets/home_product_widget.dart';
import 'package:fashion_find/views/home/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(LoadCategoriesEvent());
    context.read<BannersBloc>().add(LoadBannersEvent());
    context.read<HomeProductsBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        if (didPop) {
          return;
        } else {
          return confirmExit();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Fashion Find",
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SearchWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                  const BannersWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                  const CategoryWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                  const HomeProductWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                  const BannersWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void confirmExit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit", style: Theme.of(context).textTheme.titleLarge,),
          content: Text("Do you want to exit?", style: Theme.of(context).textTheme.bodyMedium,),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    width: 120,
                    text: "Exit",
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 120,
                    text: "Cancel",
                )
              ],
            )
          ],
        )
    );
  }
}




