import 'package:cryptodata/core/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptodata/components/presentation/widgets/searchlist.dart';
import 'package:cryptodata/components/presentation/pages/order_book_page.dart';
import 'package:cryptodata/components/presentation/widgets/show_error_widget.dart';
import 'package:cryptodata/components/presentation/widgets/progress_indicator_widget.dart';

import '../bloc/search_page_bloc.dart';

class MySearchPage extends StatelessWidget {
  final String searchTerm;
  MySearchPage(this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchTerm),
        backgroundColor: config.brandColor,
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
                return Column(
                  children: <Widget>[
                    Container(
                      key: Key("searchButton"),
                      child: state.isLoading
                          ? ProgressIndicatorWidget()
                          : SearchListItem(product, searchTerm),
                    ),
                    //Timer.periodic(Duration(seconds: 60), (timer) {});
                    SingleChildScrollView(child: MyOrderBook(searchTerm)),
                    Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          // isExtended: true,
                          child: Icon(Icons.refresh),
                          backgroundColor: config.brandColor,
                          onPressed: () {
                            context
                                .read<SearchBloc>()
                                .add(OnRefreshSearchtList(searchTerm));
                          }),
                    ),
                  ],
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
}
