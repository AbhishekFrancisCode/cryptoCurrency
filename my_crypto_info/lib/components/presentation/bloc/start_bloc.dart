//Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_crypto_info/components/data/datasource/local/db_manager.dart';
import 'package:my_crypto_info/core/error/failure.dart';

abstract class StartEvent {}

class OnLoadStart extends StartEvent {
  int tabPosition;
  OnLoadStart([this.tabPosition = 0]);
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
