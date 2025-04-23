import 'package:fashion_find/bloc/bloc_edit_user_profile/edit_user_profile_bloc.dart';
import 'package:fashion_find/bloc/bloc_edit_user_profile/edit_user_profile_event.dart';
import 'package:fashion_find/bloc/bloc_edit_user_profile/edit_user_profile_state.dart';
import 'package:fashion_find/model/user_model.dart';
import 'package:fashion_find/util/widgets/custom_button.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  @override
  Widget build(BuildContext context) {
    print("build called");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "Update Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocListener<EditUserProfileBloc, EditUserProfileState>(
        listener: (context, state) {
          print("state is : $state");
          if (state is EditUserProfileSuccessState) {
            buildCustomSnackBar();
          }
        },
        child: BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
            builder: (context, state) {
          print("state is : $state");
          if (state is EditUserProfileInitialState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Form(
                          key: context.read<EditUserProfileBloc>().formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Name",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                TextFormField(
                                  controller: context
                                      .read<EditUserProfileBloc>()
                                      .nameController,
                                  decoration: context
                                      .read<EditUserProfileBloc>()
                                      .styleTextField(
                                          "Enter name", const Icon(Icons.person)),
                                  validator: context
                                      .read<EditUserProfileBloc>()
                                      .nameValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Contact",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                TextFormField(
                                  controller: context
                                      .read<EditUserProfileBloc>()
                                      .contactController,
                                  decoration: context
                                      .read<EditUserProfileBloc>()
                                      .styleTextField(
                                          "Enter contact",
                                          const Icon(
                                              Icons.contact_phone_outlined)),
                                  validator: context
                                      .read<EditUserProfileBloc>()
                                      .contactValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Gender",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        title: const Text("Male"),
                                        value: "Male",
                                        groupValue: state.gender,
                                        onChanged: (value) {
                                          context.read<EditUserProfileBloc>().add(
                                              ChangeGenderValue(gender: value!));
                                          // state.gender = value!;
                                        },
                                        toggleable: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        title: const Text("Female"),
                                        value: "Female",
                                        groupValue: state.gender,
                                        onChanged: (value) {
                                          context.read<EditUserProfileBloc>().add(
                                              ChangeGenderValue(gender: value!));
                                          // state.gender = value!;
                                        },
                                        toggleable: true,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Address",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                TextFormField(
                                  controller: context.read<EditUserProfileBloc>().primaryAddressController,
                                  decoration: context.read<EditUserProfileBloc>().styleTextField("Enter address", const Icon(Icons.add_home_work_outlined)),
                                  validator: context.read<EditUserProfileBloc>().addressValidator,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  maxLines: null,
                                  keyboardType: TextInputType.text,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      CustomButton(
                          onTap: () {
                            if(context.read<EditUserProfileBloc>().formKey.currentState!.validate()) {
                              context.read<EditUserProfileBloc>().add(
                                  UpdateProfileEvent(
                                      name: context.read<EditUserProfileBloc>().nameController.text.trim(),
                                      contact: context.read<EditUserProfileBloc>().contactController.text.trim(),
                                      gender: state.gender!,
                                      primaryAddress: context.read<EditUserProfileBloc>().primaryAddressController.text.trim()
                                  )
                              );
                            }
                          },
                          width: 200,
                          text: "Update"
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }

  void buildCustomSnackBar() {
    return CustomSnackBar.show(context, "Profile updated successfully");
  }
}

/*
                                ValueListenableBuilder(
                                  valueListenable: context.read<EditUserProfileBloc>().selectedOption,
                                  builder: (context,currentValue, child) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile(
                                            title: const Text("Male"),
                                            value: "Male",
                                            groupValue: currentValue,
                                            onChanged: (value) {
                                              context.read<EditUserProfileBloc>().setSelectedOption(value!);
                                            },
                                            toggleable: true,
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            title: const Text("Female"),
                                            value: "Female",
                                            groupValue: currentValue,
                                            onChanged: (value) {
                                              context.read<EditUserProfileBloc>().setSelectedOption(value!);
                                            },
                                            toggleable: true,
                                          ),
                                        )
                                      ],
                                    );
                                  }
                              ),
 */