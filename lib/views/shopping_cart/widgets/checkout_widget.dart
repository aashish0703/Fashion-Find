import 'package:flutter/material.dart';

import '../../../model/shopping_cart_model.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({
    super.key, required this.cartItem,
  });

  final List<CartItem> cartItem;

  @override
  Widget build(BuildContext context) {

    double totalCartAmount = 0.0;
    for (var item in cartItem) {
      totalCartAmount += item.quantity * item.price;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(213, 172, 121, 1)
      ),
      child: ListTile(
        leading: const Icon(Icons.currency_rupee),
        title: Text("Checkout",  style: Theme.of(context).textTheme.bodyLarge,),
        subtitle: Text("Total cart amout: ${totalCartAmount.toStringAsFixed(2)}"),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}