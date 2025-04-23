import 'package:fashion_find/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fashion_find/bloc/bloc_show_address/show_address_bloc.dart';
import 'package:fashion_find/bloc/bloc_show_address/show_address_event.dart';
import 'package:fashion_find/bloc/bloc_show_address/show_address_state.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';
import '../util/util.dart';

class ShowAddressPage extends StatefulWidget {
  const ShowAddressPage({super.key});

  @override
  State<ShowAddressPage> createState() => _ShowAddressPageState();
}

class _ShowAddressPageState extends State<ShowAddressPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ShowAddressBloc>().add(LoadAllAddressEvent(uid: Util.uid!));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addAddressPage);
          },
        icon: const Icon(Icons.add_circle),
        label: const Text("Add address"),
      ),
      appBar: AppBar(
        title: const Text("Addresses"),
      ),
      body: BlocListener<ShowAddressBloc, ShowAddressState>(
        listener: (context, state) {
          print("[ShowAddressState] state is : $state");
          if(state is AddressDeletedState) {
            addressDeletedSnackBar();
          }
        },
        child: BlocBuilder<ShowAddressBloc, ShowAddressState>(
            builder: (context, state) {
              print("[ShowAddressState] state is : $state");
              if(state is ShowAddressLoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if(state is ShowAddressLoadedState) {
                return StreamBuilder(
                    stream: state.user,
                    builder: (context, snapshot) {
                      if(snapshot.hasError) {
                        return const Center(child: Text("Something went wrong\nPlease try later"),);
                      }
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasData) {
                        final userData = AppUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                        print(userData.primaryAddress.isEmpty);
                        print(userData.secondaryAddresses!.isEmpty);

                        return (userData.primaryAddress.isEmpty && userData.secondaryAddresses!.isEmpty) ? const Center(child: Text("No address added")) :
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.03,
                                ),
                                Text("Your Addresses are: ", style: Theme.of(context).textTheme.headlineMedium,),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.03,
                                ),
                                userData.primaryAddress.isEmpty ? const SizedBox.shrink() :
                                Container(
                                  width: MediaQuery.of(context).size.width*1,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(248, 223, 191, 1)
                                  ),
                                  child: Column(
                                    children: [
                                      Text(userData.primaryAddress, style: Theme.of(context).textTheme.bodyLarge,),
                                      const Divider(),
                                      GestureDetector(
                                          onTap: () {
                                            print(userData.primaryAddress);
                                            context.read<ShowAddressBloc>().add(DeletePrimaryAddressEvent(uid: Util.uid!));
                                            context.read<ShowAddressBloc>().add(LoadAllAddressEvent(uid: Util.uid!));
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              const Text("Delete"),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              const Icon(Icons.delete),
                                            ],
                                          )
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                userData.secondaryAddresses!.isEmpty ? const SizedBox.shrink() :
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: userData.secondaryAddresses?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*1,
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: const Color.fromRGBO(248, 223, 191, 1)
                                            ),
                                            child: Column(
                                              children: [
                                                Text(userData.secondaryAddresses![index], style: Theme.of(context).textTheme.bodyLarge,),
                                                const Divider(),
                                                GestureDetector(
                                                    onTap: () {
                                                      print(userData.secondaryAddresses![index]);
                                                      context.read<ShowAddressBloc>().add(
                                                          DeleteAddressEvent(
                                                              uid: Util.uid!,
                                                              address: userData.secondaryAddresses![index]
                                                          )
                                                      );
                                                      context.read<ShowAddressBloc>().add(LoadAllAddressEvent(uid: Util.uid!));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        const Text("Delete"),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                                        const Icon(Icons.delete),
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.01,
                                          )
                                        ],
                                      );
                                    })
                              ],
                            )
                        );
                      }
                      return const SizedBox.shrink();
                    });
              }
              if(state is ShowAddressErrorState) {
                return const Center(child: Text("Something went wrong\nPlease try later"),);
              }
              return const SizedBox.shrink();
            }),
      )


    );
  }

  void addressDeletedSnackBar() => CustomSnackBar.show(context, "Address deleted successfully");
}
