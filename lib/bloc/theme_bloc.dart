import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
        theme: ThemeData.light(),
      );

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeToggled) {
      if (state.theme == ThemeData.light()) {
        yield ThemeState(theme: ThemeData.dark());
      } else {
        yield ThemeState(theme: ThemeData.light());
      }
    }
  }
}
