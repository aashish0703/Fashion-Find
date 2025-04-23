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
                          Text("Date: ", style: Theme.of(context).textTheme.titleMedium,),
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                          Text("${state.orderList[index].createdAt.day}"
                              "/${state.orderList[index].createdAt.month}"
                              "/${state.orderList[index].createdAt.year}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Text("Total amount: ", style: Theme.of(context).textTheme.titleMedium,),
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                          Text(
                            "${state.orderList[index].totalAmount}",
                            style: Theme.of(context).textTheme.titleMedium,
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