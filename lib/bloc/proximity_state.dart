import 'package:equatable/equatable.dart';

abstract class ProximityState extends Equatable {
  const ProximityState();
  @override
  List<Object> get props => [];
}

class ProximityNegative extends ProximityState {}

class ProximityPositive extends ProximityState {}
