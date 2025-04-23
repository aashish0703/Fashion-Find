// import 'package:fashion_find/authentication/presentation/bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Opacity(
//             opacity: 0.3,
//             child: Image.asset(
//               "assets/on_boarding_page.jpg",
//               height: double.infinity,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 100,),
//                   Text(
//                     "Login",
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   Text(
//                       "Hi! Welcome",
//                       style: Theme.of(context).textTheme.titleLarge
//                   ),
//                   const SizedBox(height: 100,),
//                   Form(
//                       key: context.read<AuthBloc>().loginFormKey,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Email",
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                             ),
//                             TextFormField(
//                               controller: context.read<AuthBloc>().loginEmailController,
//                               decoration: context.read<AuthBloc>().styleTextField("Enter email", const Icon(Icons.mail_outline_rounded)),
//                               keyboardType: TextInputType.emailAddress,
//                               validator: context.read<AuthBloc>().emailValidator,
//                               autovalidateMode: AutovalidateMode.onUserInteraction,
//                             ),
//                             const SizedBox(height: 25,),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Password",
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                             ),
//                             TextFormField(
//                               controller: context.read<LoginBloc>().passwordController,
//                               decoration: context.read<LoginBloc>().styleTextField("Enter password", const Icon(Icons.password)),
//                               obscureText: true,
//                               validator: context.read<LoginBloc>().passwordValidator,
//                               autovalidateMode: AutovalidateMode.onUserInteraction,
//                             ),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(context, "/forgotPassword");
//                                 },
//                                 child: Text(
//                                   "Forgot Password",
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 40,),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   if(context.read<LoginBloc>().formKey.currentState!.validate()) {
//                                     context.read<LoginBloc>().add(
//                                         LoginRequestEvent(
//                                             email: context.read<LoginBloc>().emailController.text.trim(),
//                                             password: context.read<LoginBloc>().passwordController.text.trim()
//                                         )
//                                     );
//                                     context.read<LoginBloc>().emailController.clear();
//                                     context.read<LoginBloc>().passwordController.clear();
//                                   }
//                                 },
//                                 child: const Text("Login")
//                             ),
//                             const SizedBox(height: 20,),
//                             Text("Or sign in with", style: Theme.of(context).textTheme.bodySmall,),
//                             const SizedBox(height: 50,),
//                             GestureDetector(
//                               onTap: () {
//                                 context.read<LoginBloc>().add(LoginWithGoogleEvent());
//                               },
//                               child: CircleAvatar(
//                                 radius: 30,
//                                 backgroundImage: const Image(image: AssetImage("assets/google_logo.jpg")).image,
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
