import 'package:cryptodata/components/data/models/ticker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SearchListItem extends StatelessWidget {
  final Ticker search;
  final String searchTerm;
  const SearchListItem(this.search, this.searchTerm);

  @override
  Widget build(BuildContext context) {
    String cdate = DateFormat("dd MMM yyyy").format(DateTime.now());
    String tdata = DateFormat("hh:mm:ss").format(DateTime.now());
    return Container(
        //height: MediaQuery.of(context).size.height,
        // color: Colors.amber,
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListTile(
          leading: Text(
            '${searchTerm.toUpperCase()}',
            style: GoogleFonts.josefinSans(
                fontSize: 52, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          title: Text(
            '${cdate}, ${tdata}',
            style: GoogleFonts.josefinSans(fontSize: 15),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: Column(children: [
                      Text(
                        'OPEN',
                        style: GoogleFonts.josefinSans(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${search.open}',
                        style: GoogleFonts.josefinSans(
                            fontSize: 32, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                    trailing: Column(children: [
                      Text(
                        'HIGH',
                        style: GoogleFonts.josefinSans(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${search.high}',
                        style: GoogleFonts.josefinSans(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    minVerticalPadding: 5.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: Column(children: [
                      Text(
                        'LOW',
                        style: GoogleFonts.josefinSans(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${search.low}',
                        style: GoogleFonts.josefinSans(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    trailing: Column(children: [
                      Text(
                        'LAST',
                        style: GoogleFonts.josefinSans(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${search.last}',
                        style: GoogleFonts.josefinSans(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: ListTile(
                      leading: Column(children: [
                    Text(
                      'VOLUME',
                      style: GoogleFonts.josefinSans(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${search.volume}',
                      style: GoogleFonts.josefinSans(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ])),
                ),
              ],
            )),
      ),
    ]));
  }
}
