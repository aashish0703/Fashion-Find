import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              "assets/on_boarding_page.jpg",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Text(
                    "Fashion Find",
                  style: Theme.of(context).textTheme.displayMedium
                ),
                const SizedBox(height: 10),
                Text(
                    "Style Meets Comfort",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 250,),
                CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.loginPage);
                    },
                    width: 300,
                    text: "Login"
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.registrationPage);
                  },
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromRGBO(213, 172, 121, 1), width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
