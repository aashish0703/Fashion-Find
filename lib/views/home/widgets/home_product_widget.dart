import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc_home_products/home_products_bloc.dart';
import '../../../bloc/bloc_home_products/home_products_event.dart';
import '../../../bloc/bloc_home_products/home_products_state.dart';
import '../../../model/product_model.dart';
import '../../../route_generator/routes.dart';
import '../../../util/widgets/custom_image.dart';

class HomeProductWidget extends StatelessWidget {
  const HomeProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.712,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(251, 234, 213, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Row(
              children: [
                Text("Shop for T-shirts", style: Theme.of(context).textTheme.titleLarge,),
                // const Spacer(),
                // CircleAvatar(
                //     radius: 20,
                //     child: Align(
                //       alignment: Alignment.center,
                //       child: IconButton(
                //           onPressed: () {
                //             Navigator.pushNamed(context, Routes.productPage, arguments: "");
                //           },
                //           icon: const Icon(Icons.arrow_forward)
                //       ),
                //     )
                // )
              ],
            ),
          ),
          const Divider(),
          BlocBuilder<HomeProductsBloc, HomeProductsState>(
              builder: (context, state) {
                if(state is HomeProductsLoadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(state is HomeProductsLoadedState) {
                  return StreamBuilder(
                      stream: state.productsStream,
                      builder: (context, snapshot) {
                        if(snapshot.hasError) {
                          return const Center(child: Text("Something went wrong\nTry again later"),);
                        }
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        if(snapshot.hasData) {
                          final productsList = snapshot.data!.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();

                          return Flexible(
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    // mainAxisSpacing: 1,
                                    // crossAxisSpacing: 1,
                                    childAspectRatio: 1.3
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: productsList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.productDetailsPage, arguments: productsList[index]);
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CustomImage(
                                            url: productsList[index].productImage,
                                            height: MediaQuery.of(context).size.height*0.2,
                                            width: MediaQuery.of(context).size.width*0.4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height*0.02,
                                        ),
                                        Text(
                                          productsList[index].productName,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          );
                        }

                        return const SizedBox.shrink();

                      });
                }
                if(state is HomeProductsErrorState) {
                  return Center(child: Text("Error: ${state.errorMessage}"),);
                }

                return const SizedBox.shrink();
              }
          )
        ],
      ),
    );
  }
}