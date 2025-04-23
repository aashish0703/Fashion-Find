import 'package:fashion_find/bloc/bloc_registration/registration_event.dart';
import 'package:fashion_find/bloc/bloc_registration/registration_state.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_registration/registration_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if(state is RegistrationErrorState) {
              dialogBox(state);
            }
            if(state is RegistrationSuccessState) {
              CustomSnackBar.show(context, "Registration Successful");
              Navigator.pushReplacementNamed(context, Routes.landingPage);
            }
          },
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              if(state is RegistrationInitialState) {
                return registerView();
              }
              if(state is RegistrationLoadingState) {
                return Stack(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        "assets/on_boarding_page.jpg",
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Center(child: CircularProgressIndicator(),),
                  ],
                );
              }
              return const SizedBox.shrink();
            }
        ),
      )
    );
  }

  void dialogBox(RegistrationErrorState state) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error", style: Theme.of(context).textTheme.titleLarge,),
          content: Text(state.errorMessage, style: Theme.of(context).textTheme.bodyMedium,),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK", style: Theme.of(context).textTheme.bodyMedium,)
            ),
          ],
        )
    );
  }

  Stack registerView() {
    return Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      "assets/on_boarding_page.jpg",
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 100,),
                          Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 30,),
                          Form(
                            key: context.read<RegistrationBloc>().formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Name",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: context.read<RegistrationBloc>().nameController,
                                    decoration: context.read<RegistrationBloc>().styleTextField("Enter name", const Icon(Icons.person)),
                                    textCapitalization: TextCapitalization.words,
                                    validator: context.read<RegistrationBloc>().nameValidator,
                                  ),
                                  const SizedBox(height: 15,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Email",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: context.read<RegistrationBloc>().emailController,
                                    decoration: context.read<RegistrationBloc>().styleTextField("Enter email", const Icon(Icons.mail_outline_rounded)),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: context.read<RegistrationBloc>().emailValidator,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  const SizedBox(height: 15,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Password",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: context.read<RegistrationBloc>().passwordController,
                                    decoration: context.read<RegistrationBloc>().styleTextField("Enter password", const Icon(Icons.password)),
                                    obscureText: true,
                                    textCapitalization: TextCapitalization.words,
                                    validator: context.read<RegistrationBloc>().passwordValidator,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  const SizedBox(height: 15,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Contact",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: context.read<RegistrationBloc>().contactController,
                                    decoration: context.read<RegistrationBloc>().styleTextField("Enter contact no", const Icon(Icons.contact_phone_outlined)),
                                    keyboardType: TextInputType.phone,
                                    validator: context.read<RegistrationBloc>().contactValidator,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  const SizedBox(height: 15,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Address",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: context.read<RegistrationBloc>().primaryAddressController,
                                    decoration: context.read<RegistrationBloc>().styleTextField("Enter address", const Icon(Icons.add_home_work_outlined)),
                                    validator: context.read<RegistrationBloc>().addressValidator,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textCapitalization: TextCapitalization.words
                                  ),
                                  const SizedBox(height: 20,),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(context.read<RegistrationBloc>().formKey.currentState!.validate()) {
                                          context.read<RegistrationBloc>().add(
                                              RegistrationRequestEvent(
                                                  name: context.read<RegistrationBloc>().nameController.text.trim(),
                                                  email: context.read<RegistrationBloc>().emailController.text.trim(),
                                                  password: context.read<RegistrationBloc>().passwordController.text.trim(),
                                                  contact: context.read<RegistrationBloc>().contactController.text.trim(),
                                                primaryAddress: context.read<RegistrationBloc>().primaryAddressController.text.trim(),
                                              )
                                          );
                                          context.read<RegistrationBloc>().nameController.clear();
                                          context.read<RegistrationBloc>().emailController.clear();
                                          context.read<RegistrationBloc>().passwordController.clear();
                                          context.read<RegistrationBloc>().contactController.clear();
                                          context.read<RegistrationBloc>().primaryAddressController.clear();
                                        }
                                      },
                                      child: const Text("Register")
                                  ),
                                  const SizedBox(height: 30,),
                                  Text("Or sign in with", style: Theme.of(context).textTheme.bodySmall,),
                                  const SizedBox(height: 30,),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<RegistrationBloc>().add(LoginWithGoogleEvent());
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: const Image(image: AssetImage("assets/google_logo.jpg")).image,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
  }
}
