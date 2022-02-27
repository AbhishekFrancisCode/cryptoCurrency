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
    var ask = _getList(search.bids[index].toString());
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("${bid[0]}",
              style: GoogleFonts.josefinSans(fontSize: 14),
              textAlign: TextAlign.left),
          Text("${bid[1]}",
              style: GoogleFonts.josefinSans(fontSize: 14),
              textAlign: TextAlign.left),
          Text("${ask[1]}",
              style: GoogleFonts.josefinSans(fontSize: 14),
              textAlign: TextAlign.left),
          Text("${ask[0]}",
              style: GoogleFonts.josefinSans(fontSize: 14),
              textAlign: TextAlign.left),
        ]),
      )
    ]);
  }

  _getList(String list) {
    final removedBrackets = list.substring(1, list.length - 1);
    final parts = removedBrackets.split(', ');
    return parts;
  }
}
