import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cryptodata/components/presentation/widgets/searchlist.dart';
import 'package:cryptodata/components/presentation/pages/order_book_page.dart';
import 'package:cryptodata/components/presentation/widgets/show_error_widget.dart';
import 'package:cryptodata/components/presentation/widgets/progress_indicator_widget.dart';

import '../bloc/search_page_bloc.dart';

class MySearchPage extends StatefulWidget {
  final String searchTerm;
  MySearchPage(this.searchTerm);

  @override
  _MySearchPageState createState() => _MySearchPageState(this.searchTerm);
}

class _MySearchPageState extends State<MySearchPage> {
  String searchTerm;
  _MySearchPageState(this.searchTerm);
  bool _isListening = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchTerm),
        backgroundColor: HexColor("#a0bcd6"),
      ),
      body: Column(children: [
        Expanded(
          child: BlocProvider(
            create: (context) => SearchBloc()..add(OnSearch(searchTerm)),
            child:
                BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state is SearchLoaded) {
                final list = state.list;
                var product = list;
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        key: Key("searchButton"),
                        child: state.isLoading
                            ? ProgressIndicatorWidget()
                            : SearchListItem(product, searchTerm),
                      ),
                      SingleChildScrollView(child: MyOrderBook(searchTerm)),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.bottomRight,
                        child: AvatarGlow(
                          animate: _isListening,
                          glowColor: Theme.of(context).primaryColor,
                          endRadius: 55.0,
                          duration: const Duration(milliseconds: 2000),
                          repeatPauseDuration: const Duration(milliseconds: 100),
                          repeat: true,
                          child: FloatingActionButton(
                            backgroundColor: HexColor("#a0bcd6"),
                            onPressed: _listen,
                            child:
                                Icon(_isListening ? Icons.refresh : Icons.refresh_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is SearchError) {
                return ShowErrorWidget(
                  state.errorMessage,
                  onPressed: () =>
                      context.read<SearchBloc>().add(OnSearch(searchTerm)),
                );
              }
              return ProgressIndicatorWidget();
            }),
          ),
        ),
      ]),
    );
  }

  void _listen() async {
    if (!_isListening) {
      setState(() => _isListening = true);
      Timer(Duration(seconds: 2), () {
        setState(() => _isListening = false);
      });
    }
  }
}
