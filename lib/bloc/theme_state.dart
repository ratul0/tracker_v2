import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData theme;

  const ThemeState({@required this.theme}) : assert(theme != null);

  @override
  List<Object> get props => [theme];
}
