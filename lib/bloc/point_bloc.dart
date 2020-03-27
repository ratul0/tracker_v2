import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackerv2/models/models.dart';
import './bloc.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final LocationBloc locationBloc;
  StreamSubscription locationBlocSubscription;

  PointBloc(this.locationBloc) {
    locationBlocSubscription = locationBloc.listen((state) {
      if (state is LocationTrackingInProgress) {
        add(LocationProcessedForPoints(state.positions));
      }
      if (state is LocationTrackingPaused) {
        add(LocationProcessedForPoints(state.positions));
      }
      if (state is LocationEmpty) {
        add(PointListInitialized());
      }
    });
  }

  @override
  PointState get initialState => EmptyPointList();

  @override
  Stream<PointState> mapEventToState(
    PointEvent event,
  ) async* {
    final currentState = state;

    if (event is LocationProcessedForPoints) {
      yield* _mapPositionsToGraphPoints(currentState, event);
    }
    if (event is PointListInitialized) {
      yield PointTrackingInProgress(points: []);
      yield EmptyPointList();
    }
  }

  @override
  Future<void> close() {
    locationBlocSubscription.cancel();
    return super.close();
  }

  Stream<PointState> _mapPositionsToGraphPoints(
      PointState currentState, LocationProcessedForPoints event) async* {
    Position firstPosition = event.positions[0];
    List<GraphPoint> points = [];
    for (Position position in event.positions) {
      points.add(
        GraphPoint((position.latitude - firstPosition.latitude) * 1500,
            (position.longitude - firstPosition.longitude) * 1500),
      );
    }
    yield PointTrackingInProgress(points: points);
  }
}
