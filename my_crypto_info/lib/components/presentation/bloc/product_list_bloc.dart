//Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptodata/core/error/failure.dart';

abstract class CryptoListEvent {}

class OnLoadCryptoList extends CryptoListEvent {}

class OnRefreshCryptoList extends CryptoListEvent {}

//States
abstract class CryptoListState {}

class CryptoListLoading extends CryptoListState {}

class CryptoListLoaded extends CryptoListState {
  // final List<CryptoList> list;
  // final bool isLoading;
  // CryptoListLoaded(this.list, [this.isLoading = false]);
}

class CryptoListError extends CryptoListState {
  final String errorMessage;
  CryptoListError(this.errorMessage);
}

//Bloc
class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc() : super(CryptoListLoading());

  Stream<CryptoListState> mapEventToState(CryptoListEvent event) async* {
    final _currentState = state;
    if (event is OnLoadCryptoList) {
      try {
        //final response = await RemoteRepository().getCryptoList();
        yield CryptoListLoaded();
      } on Failure catch (e) {
        yield CryptoListError(e.message);
      }
    } else if (event is OnRefreshCryptoList) {
      if (_currentState is CryptoListLoaded) {
        yield CryptoListLoaded();
      }
    }
  }
}
