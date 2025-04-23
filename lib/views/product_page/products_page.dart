
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/views/product_page/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';



class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, this.name});

  final String? name;
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.wishlistPage);
                  },
                  icon: const Icon(Icons.favorite_border_rounded)),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.shoppingCartPage);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
              const SizedBox(
                width: 5,
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.name ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const ProductCardWidget(),
          ],
        ),
      ),
    );
  }
}


