import 'package:fashion_find/bloc/bloc_category_detail/category_detail_bloc.dart';
import 'package:fashion_find/bloc/bloc_category_detail/category_detail_event.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/bloc_categories/categories_bloc.dart';
import '../../../bloc/bloc_categories/categories_state.dart';
import '../../../model/category_model.dart';
import '../../../util/widgets/custom_image.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.width * 0.6,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
            )
          ]
      ),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if(state is CategoriesLoadingState) {
              return Skeletonizer(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 6,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 17,),
                              CustomImage(
                                url: "",
                                height: MediaQuery.of(context).size.width * 0.12,
                                width: MediaQuery.of(context).size.width * 0.12,
                              ),
                              const Spacer(),
                              const Text(
                                  "dummy text"
                              ),
                              const SizedBox(height: 10,)
                            ],
                          ),
                        );
                      }
                  )
              );
            }
            if(state is CategoriesLoadedState) {
              return FutureBuilder(
                  future: state.categories,
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      return const Text("Something went wrong\nTry again later");
                    }
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Skeletonizer(
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                              ),
                              itemCount: 6,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 17,),
                                      CustomImage(
                                        url: "",
                                        height: MediaQuery.of(context).size.width * 0.12,
                                        width: MediaQuery.of(context).size.width * 0.12,
                                      ),
                                      const Spacer(),
                                      const Text(
                                          "dummy text"
                                      ),
                                      const SizedBox(height: 10,)
                                    ],
                                  ),
                                );
                              }
                          )
                      );
                    }
                    if(snapshot.hasData) {
                      final categoryList = snapshot.data!.docs
                          .map((doc) => Category.fromJson(doc.data()))
                          .toList();

                      return GridView.builder(
                        primary: false,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8
                          ),
                          itemCount: categoryList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<CategoryDetailBloc>().add(LoadCategoryDetails(categoryId: categoryList[index].categoryId));
                                Navigator.pushNamed(context, Routes.categoryDetailPage, arguments: categoryList[index]);
                              },
                              // child: Container(
                              //   margin: const EdgeInsets.all(4),
                              //   decoration: BoxDecoration(
                              //     gradient: const LinearGradient(
                              //         colors: [
                              //           Color.fromRGBO(253,244,234, 1),
                              //           Color.fromRGBO(252, 239, 223, 1),
                              //           Color.fromRGBO(248, 223, 191, 1),
                              //           Color.fromRGBO(246, 213, 170, 0.8),
                              //           Color.fromRGBO(244, 202, 149, 0.9)
                              //         ],
                              //         begin: Alignment.topCenter,
                              //         end: Alignment.bottomCenter
                              //     ),
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(252, 217, 174, 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CustomImage(
                                        url: categoryList[index].image,
                                        height: MediaQuery.of(context).size.width * 0.13,
                                        width: MediaQuery.of(context).size.width * 0.13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                        categoryList[index].name
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.01,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                    return const SizedBox.shrink();
                  }
              );
            }
            if(state is CategoriesErrorState) {
              return const Text("Something went wrong\nTry again later");
            }
            return const SizedBox.shrink();
          }
      ),
    );
  }
}