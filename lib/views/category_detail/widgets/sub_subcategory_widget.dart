import 'package:fashion_find/bloc/bloc_product_page/product_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_product_page/product_page_event.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/bloc_sub_subcategories/sub_subcategory_bloc.dart';
import '../../../bloc/bloc_sub_subcategories/sub_subcategory_state.dart';
import '../../../model/sub_subcategory_model.dart';

class SubSubCategoriesWidget extends StatelessWidget {
  const SubSubCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubSubCategoryBloc, SubSubCategoryState>(
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
                    ? Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.95,
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(254, 250, 244, 0.8)),
                        child: Text(
                          "No Data",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: subSubCategoriesList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final name = subSubCategoriesList[index].name;
                          return GestureDetector(
                            onTap: () {
                              context.read<ProductPageBloc>().add(
                                  LoadSubSubCategoryProductEvent(
                                      subSubcategoryId: subSubCategoriesList[index].subsubcategoryId));
                              Navigator.pushNamed(context, Routes.productPage, arguments: name);
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: const EdgeInsets.all(2),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromRGBO(254, 250, 244, 0.8)),
                              child: Text(
                                subSubCategoriesList[index].name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          );
                        });
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
    });
  }
}
