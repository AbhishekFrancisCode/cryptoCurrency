import 'package:cryptodata/components/data/models/order_book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderBookListItem extends StatelessWidget {
  final OrderBook search;
  final String searchTerm;
  final int index;
  const OrderBookListItem(this.search, this.searchTerm, this.index);

  @override
  Widget build(BuildContext context) {
    var bid = _getList(search.bids[index].toString());
    var ask = _getList(search.asks[index].toString());
    return _getRowList(bid[0],bid[1],ask[1],ask[0]);
  }
    _getRowList(
    String a,
    String b,
    String c,
    String d,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: [
      //SizedBox(height: 20),
      Text("${a}"),
      Text("${b}"),
      Text("${c}"),
      Text("${d}"),
    ]);
  }

  _getList(String list) {
    final removedBrackets = list.substring(1, list.length - 1);
    final parts = removedBrackets.split(', ');
    return parts;
  }
}
