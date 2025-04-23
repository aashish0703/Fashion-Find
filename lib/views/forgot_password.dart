import 'package:fashion_find/bloc/bloc_forgot_password/forgot_password_bloc.dart';
import 'package:fashion_find/bloc/bloc_forgot_password/forgot_password_event.dart';
import 'package:fashion_find/bloc/bloc_forgot_password/forgot_password_state.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if(state is ForgotPasswordErrorState) {
              dialogBox(state);
            }
            if(state is ForgotPasswordSuccessState) {
              CustomSnackBar.show(context, "Mail send. Please login again after updating password");
            }
          },
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              if(state is ForgotPasswordInitialState) {
                return forgotPasswordView();
              }
              if(state is ForgotPasswordLoadingState) {
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
      ),
    );
  }

  void dialogBox(ForgotPasswordErrorState state) {
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

  Stack forgotPasswordView() {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 200,),
                  Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 80,),
                  Text(
                    "Enter the mail on which you want to send the password reset mail",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30,),
                  Form(
                    key: context.read<ForgotPasswordBloc>().formKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextFormField(
                            controller: context.read<ForgotPasswordBloc>().emailController,
                            validator: context.read<ForgotPasswordBloc>().emailValidator,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: context.read<ForgotPasswordBloc>().styleTextField("Enter email", const Icon(Icons.email_outlined)),
                          ),
                          const SizedBox(height: 50,),
                          ElevatedButton(
                              onPressed: () {
                                context.read<ForgotPasswordBloc>().add(
                                    ForgotPasswordRequestEvent(
                                        email: context.read<ForgotPasswordBloc>().emailController.text.trim()
                                    )
                                );
                                context.read<ForgotPasswordBloc>().emailController.clear();
                              },
                              child: const Text("Send")
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
