// To parse this JSON data, do
//
//     final cryptoList = cryptoListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CryptoList> cryptoListFromJson(String str) =>
    List<CryptoList>.from(json.decode(str).map((x) => CryptoList.fromJson(x)));

String cryptoListToJson(List<CryptoList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoList {
  CryptoList({
    this.trading = '',
    this.baseDecimals = "",
    this.urlSymbol = "",
    this.name = "",
    this.instantAndMarketOrders = "",
    this.minimumOrder = "",
    this.counterDecimals = "",
    this.description = "",
  });

  String trading = "";
  String baseDecimals = " ";
  String urlSymbol = "";
  String name = "";
  String instantAndMarketOrders = "";
  String minimumOrder = "";
  String counterDecimals = " ";
  String description = "";

  factory CryptoList.fromJson(Map<String, dynamic> json) => CryptoList(
        trading: json["trading"],
        baseDecimals: json["base_decimals"],
        urlSymbol: json["url_symbol"],
        name: json["name"],
        instantAndMarketOrders: json["instant_and_market_orders"],
        minimumOrder: json["minimum_order"],
        counterDecimals: json["counter_decimals"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "trading": trading,
        "base_decimals": baseDecimals,
        "url_symbol": urlSymbol,
        "name": name,
        "instant_and_market_orders": instantAndMarketOrders,
        "minimum_order": minimumOrder,
        "counter_decimals": counterDecimals,
        "description": description,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
