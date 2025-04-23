

import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_bloc.dart';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_event.dart';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_state.dart';
import 'package:fashion_find/model/product_model.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/loader.dart';
import 'package:fashion_find/util/util.dart';
import 'package:fashion_find/util/widgets/custom_image.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_product_page/product_page_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.productDetails});

  final ProductModel productDetails;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

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
      body: Stack(
        children: [
          BlocListener<ShoppingCartBloc, ShoppingCartState>(
            listener: (context, state) {
              if(state is AddItemToShoppingCart) {
                CustomSnackBar.show(context, "Product added to cart");
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: CustomImage(
                          url: widget.productDetails.productImage,
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 1,
                        )
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                          widget.productDetails.brand,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 25,
                          child: IconButton(
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            iconSize: 30,
                              onPressed: () {
                                CustomSnackBar.show(context, "Work in progress");
                              },
                              icon: const Icon(Icons.share_outlined)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                        widget.productDetails.productName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10,),
                    Wrap(
                      children: [
                        Text(
                            "₹${widget.productDetails.sellingPrice}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          "₹${widget.productDetails.price}",
                          style: const TextStyle(decoration: TextDecoration.lineThrough)
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(246,213,170, 1)
                          ),
                          child: Text(
                            "${context.read<ProductPageBloc>().calculateDiscount(widget.productDetails.price, widget.productDetails.sellingPrice)}% Off",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Text(widget.productDetails.description),
                    const SizedBox(height: 20,),
                    Text("Size", style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: MediaQuery.of(context).size.width*0.15,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productDetails.size.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                CustomSnackBar.show(context, "Work in progress");
                              },
                              child: Container(
                                // margin: const EdgeInsets.symmetric(horizontal: 5),
                                margin: const EdgeInsets.only(right: 5),
                                height: MediaQuery.of(context).size.width*0.15,
                                width: MediaQuery.of(context).size.width*0.15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text(widget.productDetails.size[index])),
                              ),
                            );
                          }
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var bloc = context.read<ProductPageBloc>();
                            var productId = widget.productDetails.productId;
                            if(await bloc.isProductWishList(productId)) {
                              OverlayLoader.show(context);
                              bloc.removeProductFromWishList(productId);
                              OverlayLoader.hide();
                              CustomSnackBar.show(context, "Item removed from favourites");
                            } else {
                              OverlayLoader.show(context);
                              bloc.saveProductToWishList(productId);
                              OverlayLoader.hide();
                              CustomSnackBar.show(context, "Item saved to favourites");
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.09,
                            width: MediaQuery.of(context).size.width*0.42,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(246,213,170, 1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Wishlist", style: Theme.of(context).textTheme.bodyLarge,),
                                const SizedBox(width: 3,),
                                const Icon(Icons.favorite_border_rounded)
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            OverlayLoader.show(context);

                            context.read<ShoppingCartBloc>().add(
                              AddItemToCart(
                                  userId: Util.uid!,
                                  item: CartItem(
                                      id: "",
                                      productId:  widget.productDetails.productId,
                                      productName: widget.productDetails.productName,
                                      price: widget.productDetails.sellingPrice,
                                      quantity: 1,
                                      stockAvailable: widget.productDetails.quantity,
                                      imageUrl: widget.productDetails.productImage
                                  )
                              )
                            );

                            OverlayLoader.hide();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.09,
                            width: MediaQuery.of(context).size.width*0.42,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(246,213,170, 1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add to Cart", style: Theme.of(context).textTheme.bodyLarge,),
                                const SizedBox(width: 3,),
                                const Icon(Icons.shopping_cart_outlined)
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   child: context.read<ShoppingCartBloc>().isLoading.value ?
          //   const CustomLoader(
          //     opacity: 1,
          //     dismissibles: false,
          //     color: Colors.black,
          //     loadingTxt: "loading..."
          //   )
          //       :  Container()
          // )

        ],
      )
    );
  }
  // OverlayEntry overlayEntry = OverlayEntry(builder: (context) =>
  // const Center(child: CircularProgressIndicator())
  // );
  // void showOverlay() {
  //   // _overlayEntry = OverlayEntry(builder: (context) =>
  //   //     const Center(child: CircularProgressIndicator())
  //   // );
  //
  //   Overlay.of(context).insert(overlayEntry);
  // }
  // void hideLoader(){
  //   overlayEntry.remove();
  // }
}
