import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_bloc.dart';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_event.dart';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_state.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/loader.dart';
import 'package:fashion_find/util/util.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:fashion_find/views/shopping_cart/widgets/checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/widgets/custom_image.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ShoppingCartBloc>().add(LoadShoppingCartItems(userId: Util.uid!));
  }

  @override
  Widget build(BuildContext context) {
    print("Build called");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: BlocListener<ShoppingCartBloc, ShoppingCartState>(
          listener: (context, state) {
            // if(state is ShoppingCartErrorState) {
            //   errorDialog( state);
            // }
            // if(state is RemoveItemFromShoppingCart) {
            //   CustomSnackBar.show(context, "Item removed from Cart");
            // }
            if(state is AddOrdersState) {
              context.read<ShoppingCartBloc>().add(LoadShoppingCartItems(userId: Util.uid!));
              Navigator.pushNamed(context, Routes.checkoutPage);
            }
      },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                builder: (context, state) {
                  print("[ShoppingCartState] current state: $state");
                  if(state is ShoppingCartErrorState) {
                    return Center(child: Text("error : ${state.errorMessage}"),);
                  }
                  if(state is ShoppingCartLoadingState) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(state is ShoppingCartLoadedState) {
                    return StreamBuilder(
                        stream: state.cartItem,
                        builder: (context, snapshot) {
                          if(snapshot.hasError) {
                            return const Center(child: Text("Something went wrong\nTry again later please"),);
                          }
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          if(snapshot.hasData) {
                            final cartItems = snapshot.data!.docs.map((doc) => CartItem.fromDocument(doc)).toList();
                            print("[ShoppingCartLoadedState] cartItems: $cartItems");

                            return cartItems.isEmpty ?
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(248, 223, 191, 1)
                                ),
                                child: Text(
                                  "Your Cart is Empty",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ) :

                                Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: cartItems.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(12),
                                                margin: const EdgeInsets.symmetric(vertical: 6),
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 10,
                                                      blurStyle: BlurStyle.outer
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: const Color.fromRGBO(251, 234, 213, 1),
                                                ),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: CustomImage(
                                                        url: cartItems[index].imageUrl,
                                                        height: MediaQuery.of(context).size.height * 0.15,
                                                        width: MediaQuery.of(context).size.height* 0.15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.05,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(cartItems[index].productName, style: Theme.of(context).textTheme.titleMedium,),
                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height*0.01,
                                                        ),
                                                        Text("₹${cartItems[index].price}", style: Theme.of(context).textTheme.titleSmall),
                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height*0.01,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerRight,
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              IconButton(
                                                                  onPressed: () {
                                                                    OverlayLoader.show(context);
                                                                    context.read<ShoppingCartBloc>().add(
                                                                        DecreaseItemQuantity(
                                                                            userId: Util.uid!,
                                                                            cartItemId: cartItems[index].id
                                                                        )
                                                                    );
                                                                    OverlayLoader.hide();
                                                                  },
                                                                  icon: const Icon(Icons.remove)
                                                              ),
                                                              Text("${cartItems[index].quantity}"),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    OverlayLoader.show(context);
                                                                    context.read<ShoppingCartBloc>().add(
                                                                        IncreaseItemQuantity(
                                                                            userId: Util.uid!,
                                                                            cartItemId: cartItems[index].id
                                                                        )
                                                                    );
                                                                    OverlayLoader.hide();
                                                                    if(cartItems[index].quantity >= cartItems[index].stockAvailable) {
                                                                      CustomSnackBar.show(context, "Can't add more items");
                                                                    }
                                                                  },
                                                                  icon: const Icon(Icons.add)
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 0,
                                                child: IconButton(
                                                    onPressed: () {
                                                      OverlayLoader.show(context);
                                                      context.read<ShoppingCartBloc>().add(
                                                          RemoveItemFromCart(
                                                              userId: Util.uid!,
                                                              cartItemId: cartItems[index].id
                                                          )
                                                      );
                                                      OverlayLoader.hide();
                                                      CustomSnackBar.show(context, "Item removed from Cart");
                                                      context.read<ShoppingCartBloc>().add(LoadShoppingCartItems(userId: Util.uid!));
                                                    },
                                                    icon: const Icon(Icons.delete)
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<ShoppingCartBloc>().add(CheckOutEvent(userId: Util.uid!));
                                        },
                                        child:  CheckoutWidget(cartItem: cartItems),
                                      ),
                                    )
                                  ],
                                );


                          }
                          return const SizedBox.shrink();
                        }
                    );
                  }
                  return const SizedBox.shrink();
                }
                ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> errorDialog(ShoppingCartErrorState state) {
    return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.errorMessage),
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


/*
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child: Container(
                                //     padding: const EdgeInsets.all(12),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: const Color.fromRGBO(248, 223, 191, 1)
                                //     ),
                                //     child: const Text("Total cart value: ₹3999"),
                                //   ),
                                // )
 */


/*
return state.cartItem.isEmpty ?
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(248, 223, 191, 1)
                          ),
                          child: Text(
                            "Your Cart is Empty",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ) :
                       ListView.builder(
                          itemCount: state.cartItem.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.cartItem[index].productItems.length,
                              itemBuilder: (context, idx) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromRGBO(251, 234, 213, 1),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CustomImage(
                                                  url: state.cartItem[index].productItems[idx].productImage,
                                                  height: MediaQuery.of(context).size.height * 0.2,
                                                  width: MediaQuery.of(context).size.height* 0.15,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width*0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.cartItem[index].productItems[idx].productName, style: Theme.of(context).textTheme.titleMedium,),
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height*0.01,
                                                  ),
                                                  Text("₹${state.cartItem[index].productItems[idx].productSellingPrice}", style: Theme.of(context).textTheme.titleSmall),
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height*0.01,
                                                  ),
                                                  Text("₹${state.cartItem[index].productItems[idx].productPrice}", style: const TextStyle(decoration: TextDecoration.lineThrough)),
                                                ],
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    context.read<ShoppingCartBloc>().add(
                                                        RemoveItemFromCart(
                                                            cartId: Util.cartId!,
                                                            productId: state.cartItem[index].productItems[idx].productId
                                                        )
                                                    );
                                                    context.read<ShoppingCartBloc>().add(LoadShoppingCartItems(cartId: Util.cartId!));
                                                  },
                                                  icon: const Icon(Icons.delete))
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            children: [
                                              const Text("Quantity: "),
                                              IconButton(
                                                  onPressed: () {

                                                  },
                                                  icon: const Icon(Icons.remove)
                                              ),
                                              Text("${state.cartItem[index].productItems[idx].productQuantity}"),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.add)
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            );
                          }
                      );
 */
