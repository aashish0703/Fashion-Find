import 'package:fashion_find/bloc/bloc_orders/orders_bloc.dart';
import 'package:fashion_find/bloc/bloc_orders/orders_event.dart';
import 'package:fashion_find/bloc/bloc_orders/orders_state.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_bloc.dart';
import 'package:fashion_find/util/util.dart';
import 'package:fashion_find/views/checkout_page/widgets/order_detail_widget.dart';
import 'package:fashion_find/views/checkout_page/widgets/user_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_user_account_page/user_account_page_event.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});


  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserAccountPageBloc>().add(LoadUserAccountPageEvent(uid: Util.uid!));
    context.read<OrdersBloc>().add(LoadCurrentOrder(userId: Util.uid!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout Page"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                ),
                Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(251, 234, 213, 1)
                      ),
                      child: Column(
                        children: [
                          const UserDetailWidget(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const OrderDetailWidget(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          BlocBuilder<OrdersBloc, OrdersState>(
                            builder: (context, state) {
                              if(state is OrdersLoadedState) {
                                return GestureDetector(
                                  onTap: () {
                                    context.read<OrdersBloc>().add(InitiatePayment(totalAmount: state.orderList[0].totalAmount));
                                    context.read<OrdersBloc>().add(LoadCurrentOrder(userId: Util.uid!));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(213, 172, 121, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: const Text("Make Payment"),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width*0.38,
              child: const SizedBox(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromRGBO(251, 234, 213, 1),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                          size: 30,
                          Icons.currency_rupee
                      )
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
