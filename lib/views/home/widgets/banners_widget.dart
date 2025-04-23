import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/bloc_banners/banners_bloc.dart';
import '../../../bloc/bloc_banners/banners_state.dart';
import '../../../model/banner_model.dart';
import '../../../util/widgets/custom_image.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: BlocBuilder<BannersBloc, BannersState>(
          builder: (context, state) {
            if(state is BannerLoadingState) {
              return Skeletonizer(
                  enabled: true,
                  child: CarouselSlider.builder(
                    itemCount: 3,
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.width * 0.5,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true
                    ),
                    itemBuilder: (context, index, realIdx) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        // child: CustomImage(url: imageUrl[index]),
                        child: const CustomImage(url:""),
                      );
                    },
                  )
              );
            }
            if(state is BannerLoadedState) {
              return StreamBuilder(
                  stream: state.bannersList,
                  builder: (context, snapshot) {
                    print("my connection state : ${snapshot.connectionState}");
                    if(snapshot.hasError) {
                      return const SizedBox(
                          height: 230,
                          child: Text("Something went wrong")
                      );
                    }
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      // return const Center(child: Text("please wait"));
                      return Skeletonizer(
                          enabled: true,
                          child: SizedBox(
                            child: CarouselSlider.builder(
                              itemCount: 3,
                              options: CarouselOptions(
                                  height: MediaQuery.of(context).size.width * 0.5,
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true
                              ),
                              itemBuilder: (context, index, realIdx) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  // child: CustomImage(url: imageUrl[index]),
                                  child: const CustomImage(url:"assets/banner_error.png", height: 200, width: 300,),
                                );
                              },
                            ),
                          )
                      );
                    }
                    if(snapshot.hasData) {

                      final bannerList = snapshot.data!.docs
                          .map((doc) => BannerModel.fromMap(doc.data()))
                          .toList();

                      // return ListView.builder(
                      //   itemCount: bannerList.length,
                      //     itemBuilder: (context, index) {
                      //       return Image.network(bannerList[index].images[index],);
                      //     }
                      // );

                      // List<String> imageUrl = [];
                      // for(int i =0; i< bannerList[0].images.length; i++) {
                      //   imageUrl.add(bannerList[0].images[i]);
                      // }
                      //
                      // print("imageURl: $imageUrl");

                      return CarouselSlider.builder(
                        itemCount: bannerList[0].images.length,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.width * 0.5,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          viewportFraction: 1,
                          aspectRatio: 16/9
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3 , vertical: 8),
                            decoration:  BoxDecoration(
                              borderRadius:BorderRadius.circular(10) ,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.outer
                                )
                              ]
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImage(url: bannerList[0].images[index])),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  }
              );
            }
            if(state is BannerErrorState) {
              return CustomImage(
                  url: "assets/banner_error.png",
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
              );
            }
            return const SizedBox.shrink();
          }
      ),
    );
  }
}