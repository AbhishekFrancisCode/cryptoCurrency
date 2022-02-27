//Events
import 'package:cryptodata/components/data/models/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; //
import 'package:cryptodata/core/error/failure.dart';
import 'package:cryptodata/components/domain/repositories/remote_repository.dart';

abstract class SearchEvent {}

class OnSearch extends SearchEvent {
  final String term;
  OnSearch(this.term);
}

class OnRefreshSearchtList extends SearchEvent {}

//States
abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final Ticker list;
  final bool isLoading;
  SearchLoaded(this.list, [this.isLoading = false]);
}

class SearchError extends SearchState {
  final String errorMessage;
  SearchError(this.errorMessage);
}

//Bloc
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading());

  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    final _currentState = state;
    if (event is OnSearch) {
      try {
        final term = event.term.trim();
        final response = await RemoteRepository().getCryptoBySearch(term);
        yield SearchLoaded(response);
      } on Failure catch (e) {
        yield SearchError(e.message);
      }
    } else if (event is OnRefreshSearchtList) {
      if (_currentState is SearchLoaded) {
        yield SearchLoaded(_currentState.list);
      }
    }
  }
}
