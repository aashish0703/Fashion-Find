import 'package:fashion_find/bloc/bloc_product_page/product_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_wishlist_page/wishlist_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_wishlist_page/wishlist_page_event.dart';
import 'package:fashion_find/bloc/bloc_wishlist_page/wishlist_page_state.dart';
import 'package:fashion_find/util/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  
  @override
  void initState() {
    super.initState();
    context.read<WishListPageBloc>().add(LoadWishListPage());
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("WishList"),
        ),
        body:
              BlocListener<WishListPageBloc, WishListPageState>(
                listener: (context, state) {
                  if(state is WishListPageErrorState) {
                    errorStateDialog( state);
                  }
                },
                child: BlocBuilder<WishListPageBloc, WishListPageState>(
                    builder: (context, state) {
                      if(state is WishListPageLoadingState) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(state is WishListPageLoadedState) {
                        return state.productDetails.isEmpty ?
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(248, 223, 191, 1)
                                ),
                                child: Text(
                                    "Your Wishlist is Empty",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                            ),
                          ) :
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                ListView.builder(
                                  itemCount: state.productDetails.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromRGBO(251, 234, 213, 1),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CustomImage(
                                              url: state.productDetails[index].productImage,
                                              height: 100,
                                              width: 100,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.05,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(state.productDetails[index].productName, style: Theme.of(context).textTheme.titleMedium,),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.01,
                                              ),
                                              Text("₹${state.productDetails[index].sellingPrice}", style: Theme.of(context).textTheme.titleSmall),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.01,
                                              ),
                                              Text("₹${state.productDetails[index].price}", style: const TextStyle(decoration: TextDecoration.lineThrough)),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                context.read<ProductPageBloc>().removeProductFromWishList(state.productDetails[index].productId);
                                                context.read<WishListPageBloc>().add(LoadWishListPage());
                                              },
                                              icon: const Icon(Icons.delete)
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  ),
                              ],
                            ),
                          );
                      }

                  return const SizedBox.shrink();
                }),
              )

      ),
    );
  }

  Future<dynamic> errorStateDialog(WishListPageErrorState state) {
    return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // title: const Text("No items in your wishlist"),
                        title: Text(state.errorMessage),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Close")
                          )
                        ],
                      );
                    }
                );
  }
}
