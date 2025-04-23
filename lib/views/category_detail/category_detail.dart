
import 'package:fashion_find/bloc/bloc_category_detail/category_detail_bloc.dart';
import 'package:fashion_find/bloc/bloc_category_detail/category_detail_state.dart';
import 'package:fashion_find/model/subcategory_model.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/bloc_sub_subcategories/sub_subcategory_bloc.dart';
import '../../bloc/bloc_sub_subcategories/sub_subcategory_event.dart';
import '../../model/category_model.dart';


class CategoryDetail extends StatefulWidget {
  const CategoryDetail({super.key, required this.categoryData});

  final Category categoryData;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<SubcategoryModel> subcategoryList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "${widget.categoryData.name}\nSection",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
                  builder: (context, state) {
                    if(state is CategoryDetailLoadingState) {
                      return Skeletonizer(
                          enabled: true,
                          child:  GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1
                              ),
                              itemCount: 4,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Center(
                                      child: Text(
                                        "dummy text",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      )
                                  ),
                                );
                              }
                          )
                      );
                    }
                    if(state is CategoryDetailLoadedState) {
                      return StreamBuilder(
                          stream: state.categoryDetail,
                          builder: (context, snapshot) {
                            if(snapshot.hasError) {
                              return const Center(child: Text("Something went wrong"),);
                            }
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return Skeletonizer(
                                  enabled: true,
                                  child:  GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1
                                      ),
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Center(
                                              child: Text(
                                                "dummy text",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              )
                                          ),
                                        );
                                      }
                                  )
                              );
                            }
                            if(snapshot.hasData) {
                              final subcategoryList = snapshot.data!.docs.map((doc) => SubcategoryModel.fromJson(doc.data())).toList();

                              return subcategoryList.isEmpty ?
                                GridView.count(
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
                                ) :
                                    GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                        childAspectRatio: 1
                                      ),
                                      itemCount: subcategoryList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.showSubSubcategoryPage, arguments: subcategoryList[index]);
                                            context.read<SubSubCategoryBloc>().add(LoadSubSubCategoriesEvent(subcategoryId: subcategoryList[index].subcategoryId));
                                          },
                                          child: Card(
                                            child: Center(
                                                child: Text(
                                                  subcategoryList[index].name,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.bodyLarge,
                                                )
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
                    if(state is CategoryDetailErrorState) {
                      return  Center(
                        child: Text(
                            "Something went wrong",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }
              ),
          ),
        ],
      ),

    );
  }
}

/*
                              return ListView.builder(
                                itemCount: subcategoryList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(subcategoryList[index].name, style: Theme.of(context).textTheme.bodyLarge,),
                                        trailing: const Icon(Icons.arrow_right),
                                        onTap: () {
                                          Navigator.pushNamed(context, "/showSubSubcategoryPage");
                                        },
                                      ),
                                    );
                                  }
                              );
 */

/*
Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(248,223,191, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(subcategoryList[index].name, style: Theme.of(context).textTheme.bodyLarge,),
                                        ],
                                      ),
                                    );
 */


/*
                                            // if (value) {
                                            //   tfList[index] = true;
                                            //   for (int i = 0; i <
                                            //       tfList.length; i++) {
                                            //     if (i == index) {
                                            //       continue;
                                            //     }
                                            //     tfList[i] = false;
                                            //   }
                                            //   if (tfList[index]) {
                                            //     context.read<SubSubCategoryBloc>().add(
                                            //         LoadSubSubCategoriesEvent(
                                            //             subcategoryId: subcategoryList[index]
                                            //                 .subcategoryId));
                                            //   }
                                            // }
 */

/*
                                    return Card(
                                      child: Theme(
                                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

                                        child: ExpansionTile(
                                          // key: Key(index.toString()),
                                          // initiallyExpanded: index == context.read<CategoryDetailBloc>().selected,
                                          onExpansionChanged: (value) {
                                            if(value) {
                                              tfList[index] = true;
                                              for (int i = 0; i< tfList.length; i++) {
                                                if(i == index) {
                                                  continue;
                                                }
                                                tfList[i] = false;
                                              }
                                              if(tfList[index]){
                                                context.read<SubSubCategoryBloc>().add(LoadSubSubCategoriesEvent(subcategoryId: subcategoryList[index].subcategoryId));
                                              }
                                            }
                                          },
                                            title: Text(subcategoryList[index].name, style: Theme.of(context).textTheme.titleMedium,),
                                          children:  const [
                                            SubSubCategoriesWidget()
                                          ],
                                        ),
                                      ),
                                    );
 */

/*
// child: ExpansionPanelList.radio(
                                        //   expansionCallback: (value, bool isSelected) {
                                        //     context.read<SubSubCategoryBloc>().add(LoadSubSubCategoriesEvent(subcategoryId: subcategoryList[index].subcategoryId));
                                        //   },
                                        //   children: [
                                        //     ExpansionPanelRadio(
                                        //         value: index,
                                        //         headerBuilder: (context, bool isExpanded) {
                                        //           return ListTile(
                                        //               title: Text(subcategoryList[index].name, style: Theme.of(context).textTheme.titleMedium,)
                                        //           );
                                        //         },
                                        //         body: const SubSubCategoriesWidget(),
                                        //     )
                                        //   ],
                                        // ),
 */

/*
// if(value) {
                                            //
                                            //   const Duration(seconds: 20000);
                                            //   context.read<CategoryDetailBloc>().selected = index;
                                            //   print("if part: ${context.read<CategoryDetailBloc>().selected}");
                                            //   context.read<SubSubCategoryBloc>().add(LoadSubSubCategoriesEvent(subcategoryId: subcategoryList[index].subcategoryId));
                                            //   print(subcategoryList[index].subcategoryId);
                                            // } else {
                                            //   context.read<CategoryDetailBloc>().selected = -1;
                                            //   print("else part : ${context.read<CategoryDetailBloc>().selected}");
                                            // }
 */


/*
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(248, 223, 191, 1),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    child: ListTile(
                                      title: Text(
                                        subcategoryList[index].name,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      onTap: () {

                                      },
                                      trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                                    ),
                                  );
 */