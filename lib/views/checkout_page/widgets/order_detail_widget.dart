import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc_orders/orders_bloc.dart';
import '../../../bloc/bloc_orders/orders_state.dart';

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if(state is OrdersLoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is OrdersLoadedState) {
            return ListView.builder(
                itemCount: state.orderList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Date: ", style: Theme.of(context).textTheme.titleMedium,)),
                          Expanded(
                            child: Text("${state.orderList[index].createdAt.day}"
                                "/${state.orderList[index].createdAt.month}"
                                "/${state.orderList[index].createdAt.year}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Total amount: ", style: Theme.of(context).textTheme.titleMedium,)),
                          Expanded(
                            child: Text(
                              "₹${state.orderList[index].totalAmount.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            );
          }
          if(state is OrdersErrorState) {
            return const Center(child: Text("Something went wrong"),);
          }
          return const SizedBox.shrink();
        }
    );
  }
}