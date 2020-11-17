import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cash_visualizer_event.dart';
part 'cash_visualizer_state.dart';

class CashVisualizerBloc extends Bloc<CashVisualizerEvent, CashVisualizerState> {
  CashVisualizerBloc() : super(CashVisualizerInitial());

  @override
  Stream<CashVisualizerState> mapEventToState(
    CashVisualizerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
