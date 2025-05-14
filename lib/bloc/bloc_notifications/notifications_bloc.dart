import 'package:fashion_find/bloc/bloc_notifications/notifications_event.dart';
import 'package:fashion_find/bloc/bloc_notifications/notifications_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  ValueNotifier<bool> isSelected = ValueNotifier(false);

  void toggleSwitch() {
    isSelected.value = !isSelected.value;
  }

  NotificationsBloc() : super(NotificationsInitialState());
}