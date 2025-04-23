import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc_user_account_page/user_account_page_bloc.dart';
import '../../../bloc/bloc_user_account_page/user_account_page_state.dart';
import '../../../model/user_model.dart';

class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAccountPageBloc, UserAccountPageState>(
        builder: (context, state) {
          if(state is UserAccountPageLoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is UserAccountPageLoadedState) {
            return StreamBuilder(
                stream: state.user,
                builder: (context, snapshot) {
                  if(snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"),);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasData) {
                    final userData = AppUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);

                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.11,
                        ),
                        Row(
                          children: [
                            Text("Name:",  style: Theme.of(context).textTheme.titleMedium,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                            Text(userData.name,  style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Text("Contact:",  style: Theme.of(context).textTheme.titleMedium,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                            Text(userData.contact,  style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Text("Address:",  style: Theme.of(context).textTheme.titleMedium,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                            Text(userData.primaryAddress,  style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }
            );
          }
          if(state is UserAccountPageErrorState) {
            return const Center(child: Text("Something went wrong"),);
          }
          return const SizedBox.shrink();
        }
    );
  }
}