import 'dart:convert';
import 'dart:io';
import 'package:cryptodata/app.dart';
import 'package:cryptodata/components/data/models/crypto.dart';
import 'package:cryptodata/components/data/models/order_book.dart';
import 'package:cryptodata/components/data/models/ticker.dart';
import 'package:cryptodata/components/domain/usecases/api_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../../core/error/failure.dart';

class ApiClient {
  final http.Client httpClient;

  ApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<ApiResponse<List<CryptoList>>> getCryptoList() async {
    final url ="https://www.bitstamp.net/api/v2/trading-pairs-info/";
     final response = await _getResponse(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final _data = cryptoListFromJson(json.toString());
      return ApiResponse(data: _data);
    } else {
      final code = response.statusCode;
      throw Failure("Something went wrong ($code). Please retry!");
    }
  }

  Future<Ticker> getCryptoBySearch(String q) async {
    final url = Uri.parse("https://www.bitstamp.net/api/v2/ticker/$q");
    final response = await http.get(url);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Ticker.fromJson(data);
    } else {
      final code = response.statusCode;
      throw Failure("Something went wrong ($code). Please retry!");
    }
  }

    Future<OrderBook> getCryptoOrderBook(String q) async {
    final url = Uri.parse("https://www.bitstamp.net/api/v2/order_book/$q");
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return OrderBook.fromJson(data);
    } else {
      final code = response.statusCode;
      throw Failure("Something went wrong ($code). Please retry!");
    }
  }

  Future<Response> _getResponse(String url) async {
    return await _withRetry(
        () => httpClient.get(Uri.parse(url)));
  }

  Future<http.Response> _withRetry(Future<Response> Function() fn) async {
    final maxRetryAttempts = 3;
    final retryDelay = 400; //millisecs
    int attempts = 0;
    while (true) {
      attempts++;
      bool canRetry = attempts <= maxRetryAttempts;
      try {
        final response = await fn();
        if (response.statusCode >= 400 && canRetry) {
          await App().init(refreshToken: true);
        } else {
          return response;
        }
      } on Exception catch (e, s) {
        if (canRetry) {
          final duration = Duration(milliseconds: (attempts) * retryDelay);
          await Future.delayed(duration);
        } else {
          if (e is SocketException) {
            throw Failure("Unable to connect to internet");
          } else {
            //Crashlytics.instance.recordError(e, s);
            throw Failure("Something went wrong. Please retry!");
          }
        }
      }
    }
  }
}
