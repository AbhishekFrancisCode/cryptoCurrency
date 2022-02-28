import 'package:cryptodata/components/data/models/order_book.dart';
import 'package:cryptodata/components/utils/utils.dart';
import 'package:flutter/material.dart';

class OrderBookListItem extends StatelessWidget {
  final OrderBook search;
  final String searchTerm;
  final int index;
  const OrderBookListItem(this.search, this.searchTerm, this.index);

  @override
  Widget build(BuildContext context) {
    var bid = Utils.getRemoveBrackets(search.bids[index].toString());
    var ask = Utils.getRemoveBrackets(search.asks[index].toString());
    return Utils.getRowOfList(bid[0],bid[1],ask[1],ask[0]);
  }

}
