import 'package:fashion_find/bloc/bloc_add_address/add_address_bloc.dart';
import 'package:fashion_find/bloc/bloc_add_address/add_address_event.dart';
import 'package:fashion_find/bloc/bloc_add_address/add_address_state.dart';
import 'package:fashion_find/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/widgets/custom_button.dart';
import '../util/widgets/custom_snackbar.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
      body: BlocListener<AddAddressBloc, AddAddressState>(
          listener: (context, state) {
            if(state is AddAddressLoadedState) {
              buildCustomSnackBar();
            }
            if(state is AddAddressErrorState) {
              error();
            }
          },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text("Add new address for delivery", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Form(
                key: context.read<AddAddressBloc>().formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Address",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextFormField(
                        controller: context.read<AddAddressBloc>().addressController,
                        decoration: context.read<AddAddressBloc>().styleTextField("Enter address", const Icon(Icons.add_home_work_outlined)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CustomButton(
                  onTap: () {
                    if(context.read<AddAddressBloc>().formKey.currentState!.validate()) {
                      context.read<AddAddressBloc>().add(
                          EventAddAddress(
                            uid: Util.uid!,
                              address: context.read<AddAddressBloc>().addressController.text.trim(),
                          )
                      );
                      context.read<AddAddressBloc>().addressController.clear();
                      Navigator.pop(context);
                    }
                  },
                  width: 200,
                  text: "Add"
              )
            ],
          ),
        ),
      )
    );
  }

  Center error() => const Center(child: Text("Something went wrong\nPlease try after sometime"),);

  void buildCustomSnackBar() {
    return CustomSnackBar.show(context, "Address added successfully");
  }
}
