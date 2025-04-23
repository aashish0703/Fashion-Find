import 'package:fashion_find/bloc/bloc_login/login_bloc.dart';
import 'package:fashion_find/bloc/bloc_login/login_event.dart';
import 'package:fashion_find/bloc/bloc_login/login_state.dart';
import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginErrorState) {
              dialogBox(state);
            }
            if(state is LoginSuccessState) {
              CustomSnackBar.show(context, "Login Successful");
              // Navigator.pushReplacementNamed(context, "/homePage");
              Navigator.pushNamedAndRemoveUntil(context, Routes.landingPage, (Route route) => false);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if(state is LoginInitialState) {
                return loginView();
              }
              if(state is LoginLoadingState) {
                return  Stack(
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

  void dialogBox(LoginErrorState state) {
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

  Stack loginView() {
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
                    "Login",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "Hi! Welcome",
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                const SizedBox(height: 100,),
                Form(
                  key: context.read<LoginBloc>().formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
                            controller: context.read<LoginBloc>().emailController,
                            decoration: context.read<LoginBloc>().styleTextField("Enter email", const Icon(Icons.mail_outline_rounded)),
                            keyboardType: TextInputType.emailAddress,
                            validator: context.read<LoginBloc>().emailValidator,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 25,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextFormField(
                            controller: context.read<LoginBloc>().passwordController,
                            decoration: context.read<LoginBloc>().styleTextField("Enter password", const Icon(Icons.password)),
                            obscureText: true,
                            validator: context.read<LoginBloc>().passwordValidator,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.forgotPasswordPage);
                              },
                              child: Text(
                                "Forgot Password",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                              onPressed: () {
                                if(context.read<LoginBloc>().formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(
                                      LoginRequestEvent(
                                          email: context.read<LoginBloc>().emailController.text.trim(),
                                          password: context.read<LoginBloc>().passwordController.text.trim()
                                      )
                                  );
                                  context.read<LoginBloc>().emailController.clear();
                                  context.read<LoginBloc>().passwordController.clear();
                                }
                              },
                              child: const Text("Login")
                          ),
                          const SizedBox(height: 20,),
                          Text("Or sign in with", style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(height: 50,),
                          GestureDetector(
                            onTap: () {
                              context.read<LoginBloc>().add(LoginWithGoogleEvent());
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: const Image(image: AssetImage("assets/google_logo.jpg")).image,
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
