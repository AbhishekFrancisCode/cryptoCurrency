import 'package:cryptodata/components/data/models/crypto.dart';
import 'package:cryptodata/components/data/models/order_book.dart';
import 'package:cryptodata/components/data/models/ticker.dart';
import 'package:cryptodata/components/domain/usecases/api_response.dart';

import '../../data/datasources/remote/api_client.dart';
import 'package:http/http.dart' as http;

class RemoteRepository {
  ApiClient _apiClient;
  static final RemoteRepository _singleton = RemoteRepository._internal();
  factory RemoteRepository() => _singleton;

  RemoteRepository._internal() {
    _apiClient = ApiClient(httpClient: http.Client());
  }
  Future<ApiResponse<List<CryptoList>>> getCryptoList() =>
      _apiClient.getCryptoList();

  Future<Ticker> getCryptoBySearch(String q) => _apiClient.getCryptoBySearch(q);
  Future<OrderBook> getCryptoOrderBook(String q) => _apiClient.getCryptoOrderBook(q);
}
