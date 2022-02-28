//Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptodata/components/data/datasources/local/db_manager.dart';
import 'package:cryptodata/core/error/failure.dart';

abstract class StartEvent {}

class OnLoadStart extends StartEvent {
  int tabPosition = 0;
  OnLoadStart([this.tabPosition]);
}

//States
abstract class StartState {}

class StartLoading extends StartState {}

class StartError extends StartState {
  final String errorMessage;
  StartError(this.errorMessage);
}

//Bloc
class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc() : super(StartLoading());

  Stream<StartState> mapEventToState(StartEvent event) async* {
    if (event is OnLoadStart) {
      try {
        await dbManager.initialized;
        yield StartLoading();
      } on Failure catch (e) {
        yield StartError(e.message);
      }
    }
  }
}
