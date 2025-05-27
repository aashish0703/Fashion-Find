
import 'package:fashion_find/route_generator/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/bloc_product_page/product_page_bloc.dart';
import '../../../bloc/bloc_product_page/product_page_state.dart';
import '../../../model/product_model.dart';
import '../../../util/widgets/custom_image.dart';
import '../../../util/widgets/custom_snackbar.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProductPageBloc>();

    return BlocBuilder<ProductPageBloc, ProductPageState>(
        builder: (context, state) {
          if (state is ProductPageLoadingState) {
            return Skeletonizer(
              enabled: true,
              child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.58),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                // child: CustomImage(url: productDetailList[index].productImage,),
                                child: const CustomImage(
                                  url: "productDetailList[index].productImage",
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 140,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 17,
                                  child: IconButton(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border_rounded)),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Some Text",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text("Some Text", style: Theme.of(context).textTheme.bodyMedium,),
                                const Wrap(
                                  children: [
                                    Text("₹some text"),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "₹some text",
                                      style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "99% off",
                                  style: TextStyle(
                                      color: Colors.brown),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          }
          if (state is ProductPageLoadedState) {
            return StreamBuilder(
                stream: state.subsubcategoryProductDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Something went wrong"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Skeletonizer(
                      enabled: true,
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.58),
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        // child: CustomImage(url: productDetailList[index].productImage,),
                                        child: const CustomImage(
                                          url: "productDetailList[index].productImage",
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Some Text",
                                              style: Theme.of(context).textTheme.bodyLarge,
                                            )),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("Some Text", style: Theme.of(context).textTheme.bodyMedium,),
                                        const Wrap(
                                          children: [
                                            Text("₹some text"),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              "₹some text",
                                              style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          "99% off",
                                          style: TextStyle(
                                              color: Colors.brown),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  if (snapshot.hasData) {
                    final productDetailList = snapshot.data!.docs
                        .map((doc) => ProductModel.fromJson(doc.data()))
                        .toList();

                    return productDetailList.isEmpty ?
                    GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2,
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Card(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Work in progress\nNo data at present",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) :
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.60
                          ),
                          itemCount: productDetailList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              key: UniqueKey(),
                              onTap: () {
                                Navigator.pushNamed(context, Routes.productDetailsPage, arguments: productDetailList[index]);
                              },
                              child: ValueListenableBuilder(
                                valueListenable: context.read<ProductPageBloc>().isSelected,
                                builder: (context, bool value, Widget? child) {
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CustomImage(
                                              url: productDetailList[index].productImage,
                                              height: 200,
                                              width: 180,
                                            ),
                                          ),
                                          Positioned(
                                            left: 140,
                                            top: 160,
                                            child: IconButton(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.zero,
                                                onPressed: () async {
                                                  var productData = productDetailList[index];
                                                  if(await bloc.isProductWishList(productData.productId)) {
                                                    bloc.removeProductFromWishList(productData.productId);
                                                    CustomSnackBar.show(context, "Product removed from wishlist");
                                                  } else {
                                                    bloc.saveProductToWishList(productData.productId);
                                                    CustomSnackBar.show(context, "Product added to wishlist");
                                                  }
                                                },
                                                isSelected: false,
                                              //   icon: const Icon(Icons.favorite_border_rounded),
                                              // selectedIcon: bloc.isSelected.value ? const Icon(Icons.favorite, color: Colors.red,) :
                                              icon: const Icon(Icons.favorite_border_rounded)
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  productDetailList[index].brand,
                                                  style: Theme.of(context).textTheme.bodyLarge,
                                                )),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(productDetailList[index].productName, style: Theme.of(context).textTheme.bodyMedium,),
                                            Wrap(
                                              children: [
                                                Text("₹${productDetailList[index].sellingPrice}"),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  "₹${productDetailList[index].price}",
                                                  style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${context.read<ProductPageBloc>().calculateDiscount(
                                                  productDetailList[index].price, productDetailList[index].sellingPrice)}% off",
                                              style: const TextStyle(
                                                  color: Colors.brown),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }
                              ),
                            );
                          }),
                    );
                  }

                  return const SizedBox.shrink();
                });
          }
          if (state is ProductPageErrorState) {}
          return const SizedBox.shrink();
        });
  }
}