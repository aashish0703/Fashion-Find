import 'package:fashion_find/bloc/bloc_landing_page/landing_page_bloc.dart';
import 'package:fashion_find/bloc/bloc_landing_page/landing_page_event.dart';
import 'package:fashion_find/bloc/bloc_landing_page/landing_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: Center(
            child: context.read<LandingPageBloc>().bottomNavScreen.elementAt(state.tabIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: context.read<LandingPageBloc>().bottomNavItems,
            currentIndex: state.tabIndex,
            elevation: 15,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            selectedItemColor: const Color.fromRGBO(213, 172, 121, 1),
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<LandingPageBloc>().add(TabChangeEvent(tabIndex: index));
            },
          ),
        );
      }
    );
  }
}
