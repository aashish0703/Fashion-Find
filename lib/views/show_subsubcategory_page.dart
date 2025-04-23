
import 'package:fashion_find/route_generator/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/bloc_product_page/product_page_bloc.dart';
import '../bloc/bloc_product_page/product_page_event.dart';
import '../bloc/bloc_sub_subcategories/sub_subcategory_bloc.dart';
import '../bloc/bloc_sub_subcategories/sub_subcategory_state.dart';
import '../model/sub_subcategory_model.dart';
import '../model/subcategory_model.dart';

class ShowSubsubcategoryPage extends StatefulWidget {
  const ShowSubsubcategoryPage({super.key, required this.subCategoryData});

  final SubcategoryModel subCategoryData;

  @override
  State<ShowSubsubcategoryPage> createState() => _ShowSubsubcategoryPageState();
}

class _ShowSubsubcategoryPageState extends State<ShowSubsubcategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "${widget.subCategoryData.name}\nSection",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 20,),
            BlocBuilder<SubSubCategoryBloc, SubSubCategoryState>(
              builder: (context, state) {
                if (state is SubSubCategoryLoadingState) {
                  return Skeletonizer(
                      child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: const Text("dummy text"),
                            );
                          }));
                }
                if (state is SubSubCategoryLoadedState) {
                  return StreamBuilder(
                      stream: state.subSubCategoryDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          final subSubCategoriesList = snapshot.data?.docs
                              .map((doc) => SubSubCategoryModel.fromJson(doc.data()))
                              .toList();
                          return Skeletonizer(

                              child: ListView.builder(
                                  itemCount: subSubCategoriesList?.length ?? 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: const Text("dummy text"),
                                    );
                                  }));

                        }
                        if (snapshot.hasData) {
                          final subSubCategoriesList = snapshot.data!.docs
                              .map((doc) => SubSubCategoryModel.fromJson(doc.data()))
                              .toList();

                          print(subSubCategoriesList.length);

                          return subSubCategoriesList.isEmpty
                              ? GridView.count(
                                 crossAxisCount: 1,
                                 childAspectRatio: 2,
                                 shrinkWrap: true,
                                 children: [
                                   SizedBox(
                                     height: 100,
                                     child: Card(
                                       child: Align(
                                         alignment: Alignment.center,
                                         child: Text(
                                           "Work in progress\nNo data at present",
                                           textAlign: TextAlign.center,
                                           style: Theme.of(context).textTheme.bodyMedium,
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                              )
                              : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              childAspectRatio: 1.5
                            ),
                              itemCount: subSubCategoriesList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context.read<ProductPageBloc>().add(
                                        LoadSubSubCategoryProductEvent(
                                            subSubcategoryId: subSubCategoriesList[index].subsubcategoryId));
                                    Navigator.pushNamed(context, Routes.productPage, arguments: subSubCategoriesList[index].name);
                                  },
                                  child: Card(
                                    child: Center(
                                      child: Text(
                                        subSubCategoriesList[index].name,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ),
                                  ),
                                );
                              },);
                        }

                        return const SizedBox.shrink();
                      });
                }
                if (state is SubSubCategoryErrorState) {
                  return const ListTile(
                    title: Text("Something went wrong"),
                  );
                }
                return const SizedBox.shrink();
              })
          ],
        ),
      ),
    );
  }
}
