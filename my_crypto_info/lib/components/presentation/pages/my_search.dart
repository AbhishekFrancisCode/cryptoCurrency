import 'package:cryptodata/components/presentation/pages/order_book.dart';
import 'package:cryptodata/components/presentation/widgets/searchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptodata/components/presentation/widgets/progress_indicator_widget.dart';
import 'package:cryptodata/components/presentation/widgets/show_error_widget.dart';

import '../bloc/search_bloc.dart';

class MySearchPage extends StatelessWidget {
  final String searchTerm;
  MySearchPage(this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchTerm),
      ),
      body: Column(children: [
        Expanded(
          child: BlocProvider(
            create: (context) => SearchBloc()..add(OnSearch(searchTerm)),
            child:
                BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state is SearchLoaded) {
                final list = state.list;
                final product = list;
                // if (list ) {
                //   return EmptyDataWidget("No products found!");
                //}
                return Column(
                  children: <Widget>[
                    Container(
                      child: state.isLoading
                          ? ProgressIndicatorWidget()
                          : SearchListItem(product,searchTerm),
                    ),
                    SingleChildScrollView(child: ShowHideDemo(searchTerm)),
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
