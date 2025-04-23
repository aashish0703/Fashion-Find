import 'package:fashion_find/bloc/bloc_orders/orders_bloc.dart';
import 'package:fashion_find/bloc/bloc_orders/orders_event.dart';
import 'package:fashion_find/bloc/bloc_orders/orders_state.dart';
import 'package:fashion_find/util/util.dart';
import 'package:fashion_find/util/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({super.key});

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {

  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(LoadAllOrders(userId: Util.uid!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
        child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if(state is OrdersLoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if(state is OrdersLoadedState) {
                return state.orderList.isEmpty ?
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(248, 223, 191, 1)
                    ),
                    child: Text(
                      "You have not placed any orders yet.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ) :
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                              child: Text("Your orders are: ", style: Theme.of(context).textTheme.headlineMedium,)
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.02,
                          ),
                          ListView.builder(
                            itemCount: state.orderList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                        child: Text(
                                            "Order Id: ${state.orderList[index].id}",
                                            style: Theme.of(context).textTheme.bodyMedium,
                                        )
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.01,
                                    ),
                                    ListView.builder(
                                      itemCount: state.orderList[index].items.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, idx) {
                                        return
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 8),
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(246, 213, 170, 1),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: CustomImage(
                                                        url: state.orderList[index].items[idx].imageUrl,
                                                      height: MediaQuery.of(context).size.height*0.19,
                                                      width: MediaQuery.of(context).size.width*0.32,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.1,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          state.orderList[index].items[idx].productName,
                                                        style: Theme.of(context).textTheme.bodyLarge,
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(context).size.height*0.01,
                                                      ),
                                                      Text(
                                                          "${state.orderList[index].items[idx].price}",
                                                        style: Theme.of(context).textTheme.bodyMedium,
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(context).size.height*0.01,
                                                      ),
                                                      Text(
                                                          "Quantity: ${state.orderList[index].items[idx].quantity}",
                                                        style: Theme.of(context).textTheme.bodyMedium,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                      }
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.02,
                                    )
                                  ],
                                );
                              }
                          )
                        ],
                      ),
                    );
              }
              if(state is OrdersErrorState) {
                return Center(child: Text("Something went wrong\n${state.errorMessage}"),);
              }

          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
