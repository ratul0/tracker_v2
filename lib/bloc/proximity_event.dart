import 'package:equatable/equatable.dart';

abstract class LocalProximityEvent extends Equatable {
  const LocalProximityEvent();
  @override
  List<Object> get props => [];
}

class ObjectDetected extends LocalProximityEvent {}

class ObjectGone extends LocalProximityEvent {}
