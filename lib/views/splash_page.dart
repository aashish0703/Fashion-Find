import 'dart:async';

import 'package:fashion_find/route_generator/routes.dart';
import 'package:fashion_find/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUser());
  }

  void checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if(mounted) {
        if (user != null) {
          Util.uid = user.uid;

          Timer(const Duration(seconds: 2),
              () => Navigator.pushReplacementNamed(context, Routes.landingPage));
        } else {
          Timer(const Duration(seconds: 2),
              () => Navigator.pushReplacementNamed(context, Routes.onBoardingPage));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(251, 234, 213, 1),
                  Color.fromRGBO(248, 223, 191, 1),
                  Color.fromRGBO(246, 213, 170, 1),
                  Color.fromRGBO(244, 202, 149, 1)
                ]
              )
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                  "assets/brand_logo.png",
                height: 200,
                width: 200,
              ),
            ),
          )
        ],
      ),
    );
  }
}
