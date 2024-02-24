import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_system_dashboard/app/modules/attendance_screen/atd_screen.dart';
import '../../app.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(this.context)
      : super(MainScreenState(widget: const HomeScreen()));

  final BuildContext context;

  void changeWidget({required final int id}) {
    switch (id) {
      case 0:
        emit(state.copyWith(widget: const AtdScreen()));
      case 1:
        emit(state.copyWith(widget: const HomeScreen()));
      case 2:
        emit(state.copyWith(widget: StudentRegister()));
        break;
      case 3:
        emit(state.copyWith(widget: const DriverRegister()));
      case 4:
        emit(state.copyWith(widget: const BusesScreen()));
      default:
        emit(state.copyWith(widget: const HomeScreen()));
    }
  }
}
