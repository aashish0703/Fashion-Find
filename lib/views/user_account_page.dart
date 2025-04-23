import 'package:fashion_find/bloc/bloc_landing_page/landing_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_landing_page/landing_page_event.dart';
import 'package:fashion_find/bloc/bloc_login/login_bloc.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_event.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_state.dart';
import 'package:fashion_find/model/user_model.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_home/home_bloc.dart';
import '../bloc/bloc_home/home_event.dart';
import '../bloc/bloc_home/home_state.dart';
import '../util/util.dart';
import '../util/widgets/custom_snackbar.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserAccountPageBloc>().add(LoadUserAccountPageEvent(uid: Util.uid!));
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        if (didPop) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (Route<dynamic> route) => false);
        } else {
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Account"),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if(state is HomeSignOutState) {
              CustomSnackBar.show(context, "Logout Successful");
              Navigator.pushNamedAndRemoveUntil(context, Routes.onBoardingPage, (Route route) => false);
            }
            if(state is UserAccountPageDeleteUserState) {
              CustomSnackBar.show(context, "Profile deleted successfully");
            }
      },
            child: BlocBuilder<UserAccountPageBloc, UserAccountPageState>(
                builder: (builder, state) {
                  if(state is UserAccountPageLoadingState) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(state is UserAccountPageLoadedState) {
                    print("inside UserAccountPageLoadedState loadedState");

                    return StreamBuilder(
                        stream: state.user,
                        builder: (context, snapshot) {
                          if(snapshot.hasError) {
                            return const Center(child: Text("Something went wrong"),);
                          }
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          if(snapshot.hasData) {
                            // print("inside hasdata");
                            // print("${snapshot.data}");
                            // print("${snapshot.data!.data()}");

                            final userData = AppUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                            // print("userData : $userData");
                            return SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Hi! ${userData.name}",
                                          style: Theme.of(context).textTheme.headlineMedium,
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.04
                                      ),

                                      GridView.count(
                                          crossAxisCount: 2,
                                        childAspectRatio: 2.5,
                                        crossAxisSpacing: MediaQuery.of(context).size.width*0.03,
                                        mainAxisSpacing: MediaQuery.of(context).size.width*0.03,
                                        shrinkWrap: true,
                                        children: [
                                          GestureDetector(
                                            onTap: ()  {
                                              Navigator.pushNamed(context, Routes.allOrdersPage);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              height: MediaQuery.of(context).size.height*0.06,
                                              width: MediaQuery.of(context).size.width*0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: const Color.fromRGBO(232, 187, 130 ,1), width: 2)
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.card_giftcard),
                                                  SizedBox( width: 5,),
                                                  Text("Orders", style: TextStyle(fontWeight: FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, Routes.helpCenterPage);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              height: MediaQuery.of(context).size.height*0.06,
                                              width: MediaQuery.of(context).size.width*0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: const Color.fromRGBO(232, 187, 130 ,1), width: 2)
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.headset_mic_outlined),
                                                  SizedBox( width: 5,),
                                                  Text("Help Center", style: TextStyle(fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, Routes.wishlistPage);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              height: MediaQuery.of(context).size.height*0.06,
                                              width: MediaQuery.of(context).size.width*0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: const Color.fromRGBO(232, 187, 130 ,1), width: 2)
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.favorite_border_rounded),
                                                  SizedBox( width: 5,),
                                                  Text("WishList", style: TextStyle(fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                                      Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.numbers),
                                          title: const Text("Addresses"),
                                          trailing: const Icon(Icons.arrow_right),
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.showAddressPage);
                                          },
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.edit),
                                          title: const Text("Edit Profile"),
                                          trailing: const Icon(Icons.arrow_right),
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.editUserProfilePage);
                                          },
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.notifications_active_outlined),
                                          title: const Text("Notifications"),
                                          trailing: const Icon(Icons.arrow_right),
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.notificationsPage);
                                          },
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          leading: const Icon(Icons.delete),
                                          title: const Text("Delete Profile"),
                                          trailing: const Icon(Icons.arrow_right),
                                          onTap: () {
                                            confirmDialog();
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      CustomButton(
                                        onTap: () {
                                          context.read<HomeBloc>().add(SignOutRequestEvent());
                                          context.read<LandingPageBloc>().add(ResetIndexEvent());
                                        },
                                        text: "Logout",
                                        width: MediaQuery.of(context).size.width*0.4,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }
                    );
                  }
                  if(state is UserAccountPageErrorState) {
                    return const Center(child: Text("Something went wrong"),);
                  }
                  return const SizedBox.shrink();
            }
          )
        )
      ),
    );
  }

  Future<dynamic> confirmDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to delete your profile"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: () {
                      context.read<UserAccountPageBloc>().add(DeleteUserEvent(uid: Util.uid!));
                      Navigator.pushNamedAndRemoveUntil(context, Routes.onBoardingPage, (Route route) => false);
                    },
                  width: 120,
                  text: "Delete",
                ),
                const SizedBox(width: 20,),
                CustomButton(
                  onTap: () {
                    Navigator.pop(context);
                    },
                  width: 120,
                  text: "Cancel",
                )
              ],
            )
          ],
        ));
  }
}

/*
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              height: MediaQuery.of(context).size.height*0.06,
                                              width: MediaQuery.of(context).size.width*0.4,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: const Color.fromRGBO(232, 187, 130 ,1), width: 2)
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.card_giftcard),
                                                  SizedBox( width: 5,),
                                                  Text("Orders", style: TextStyle(fontWeight: FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.05,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context, Routes.helpCenterPage);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                                height: MediaQuery.of(context).size.height*0.06,
                                                width: MediaQuery.of(context).size.width*0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: const Color.fromRGBO(232, 187, 130 ,1), width: 2)
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.headset_mic_outlined),
                                                    SizedBox( width: 5,),
                                                    Text("Help Center", style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.width* 0.05,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.wishlistPage);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 14),
                                            height: MediaQuery.of(context).size.height*0.06,
                                            width: MediaQuery.of(context).size.width*0.4,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: const Color.fromRGBO(232, 187, 130 ,1), width: 2)
                                            ),
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.favorite_border_rounded),
                                                SizedBox( width: 5,),
                                                Text("WishList", style: TextStyle(fontWeight: FontWeight.bold),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
 */
