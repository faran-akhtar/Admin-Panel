// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainScreenState extends Equatable {
  Widget? widget;
  MainScreenState({
    this.widget,
  });

  MainScreenState copyWith({
    Widget? widget,
  }) {
    return MainScreenState(
      widget: widget ?? this.widget,
    );
  }

  @override
  List<Object?> get props => [widget];
}
