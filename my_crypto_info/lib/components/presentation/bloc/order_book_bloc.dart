//Events
import 'package:cryptodata/components/data/models/order_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; //
import 'package:cryptodata/core/error/failure.dart';
import 'package:cryptodata/components/domain/repositories/remote_repository.dart';

abstract class OrderBookEvent {}

class OnOrderBook extends OrderBookEvent {
  final String term;
  OnOrderBook(this.term);
}

class OnRefreshProductList extends OrderBookEvent {}

//States
abstract class OrderBookState {}

class OrderBookLoading extends OrderBookState {}

class OrderBookLoaded extends OrderBookState {
  final OrderBook list;
  final bool isLoading;
  OrderBookLoaded(this.list, [this.isLoading = false]);
}

class OrderBookError extends OrderBookState {
  final String errorMessage;
  OrderBookError(this.errorMessage);
}

//Bloc
class OrderBookBloc extends Bloc<OrderBookEvent, OrderBookState> {
  OrderBookBloc(String searchTerm) : super(OrderBookLoading());

  Stream<OrderBookState> mapEventToState(OrderBookEvent event) async* {
    final _currentState = state;
    if (event is OnOrderBook) {
      try {
        final response = await RemoteRepository().getCryptoOrderBook(event.term);
        yield OrderBookLoaded(response);
      } on Failure catch (e) {
        yield OrderBookError(e.message);
      }
    } else if (event is OnRefreshProductList) {
      if (_currentState is OrderBookLoaded) {
        yield OrderBookLoaded(_currentState.list);
      }
    }
  }
}