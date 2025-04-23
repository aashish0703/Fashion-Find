import 'package:fashion_find/bloc/bloc_search/search_bloc.dart';
import 'package:fashion_find/bloc/bloc_search/search_event.dart';
import 'package:fashion_find/bloc/bloc_search/search_state.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          TextField(
            decoration: context.read<SearchBloc>().styleTextField("search", const Icon(Icons.search)),
            onChanged: (query) => context.read<SearchBloc>().add(MakeSearchEvent(searchQuery: query)),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          ),
          BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                print("[search widget] state -> $state");
                if(state is SearchLoadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(state is SearchLoadedState) {
                  print("[search widget] state.productList received: ${state.productList}");
                  return state.productList.isEmpty ? const SizedBox.shrink() :
                    ListView.builder(
                    itemCount: state.productList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                      var product = state.productList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.productDetailsPage, arguments: product);
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomImage(
                                  url: product.productImage,
                                height: MediaQuery.of(context).size.height*0.03,
                                width: MediaQuery.of(context).size.width*0.03,
                              ),
                            ),
                            title: Text(product.productName),
                            trailing: const Icon(Icons.arrow_right),
                          ),
                        );
                      }
                  );
                }
                if(state is SearchErrorState) {
                  return const Center(child: Text("something went wrong"),);
                }

                return const SizedBox.shrink();
              }
          )
        ],
      ),
    );
  }
}
