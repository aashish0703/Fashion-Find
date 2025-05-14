import 'package:fashion_find/bloc/bloc_notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text("Turn notifications ON or OFF", style: Theme.of(context).textTheme.bodyLarge,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ValueListenableBuilder(
                valueListenable: context.read<NotificationsBloc>().isSelected,
                builder: (BuildContext context, value, Widget? child) {
                  return Card(
                    child: ListTile(
                      title: const Text("Notifications"),
                      trailing: Switch(
                          value: value,
                          onChanged: (value) {
                            context.read<NotificationsBloc>().toggleSwitch();
                          }
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}
