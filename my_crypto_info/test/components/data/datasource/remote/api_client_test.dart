import 'dart:convert';

import 'package:cryptodata/components/data/datasources/remote/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){

test("Testing the network call", () async{
  //setup the test
  final apiProvider = ApiClient();
  apiProvider.httpClient = MockClient((request) async {
    final mapJson = {'url_symbol':"btcusd"};
    return Response(json.encode(mapJson),200);
  });
  final item = await apiProvider.getCryptoList();
  expect(item.data[0].urlSymbol, "btcusd");
});

test("Testing the network call", () async{
  //setup the test
  final apiProvider = ApiClient();
  apiProvider.httpClient = MockClient((request) async {
    final mapJson = {'vwap':"39118.85"};
    return Response(json.encode(mapJson),200);
  });
  final item = await apiProvider.getCryptoBySearch("btcusd");
  expect(item.last, String);
});
}