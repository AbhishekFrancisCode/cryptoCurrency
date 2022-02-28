import 'package:cryptodata/components/presentation/bloc/quick_search_list_page_bloc.dart';
import 'package:cryptodata/components/presentation/pages/search_page.dart';
import 'package:cryptodata/components/presentation/widgets/product_list_item.dart';
import 'package:cryptodata/components/presentation/widgets/progress_indicator_widget.dart';
import 'package:cryptodata/components/presentation/widgets/search_widget.dart';
import 'package:cryptodata/components/presentation/widgets/show_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/utils.dart';

class MyCryptoListPage extends StatelessWidget {
  MyCryptoListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Data"),
        backgroundColor: HexColor("#a0bcd6"),
      ),
      body: Column(children: [
        Expanded(
          child: BlocProvider(
            create: (context) => CryptoListBloc()..add(OnLoadCryptoList()),
            child: BlocBuilder<CryptoListBloc, CryptoListState>(
                builder: (context, state) {
              if (state is CryptoListLoaded) {
                final list = state.list;
                final count = list.length;
                final crypto = list;
                return Column(
                  children: <Widget>[
                    Container(
                      child: SearchWidget(
                        onTextChanged: (searchTerm) {
                          Utils.navigateToPage(
                              context, MySearchPage(searchTerm));
                        },
                      ),
                    ),
                    Container(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 100,
                          child: Image.asset(
                              "./assets/image/Cryptocurrency-graph.png"),
                        ),
                      ),
                    ),
                    Text("Enter a currency pair to load data"),
                    Divider(
                      thickness: 10.0,
                      color: HexColor("#a0bcd6"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left:10),
                      alignment: Alignment.centerLeft,
                      child: Text("Quick Links"),
                    ),
                    Expanded(
                        child: state.isLoading
                            ? ProgressIndicatorWidget()
                            : Container(
                                padding: EdgeInsets.all(8),
                                child: GridView.builder(
                                  itemCount: count,
                                  itemBuilder: (context, index) =>
                                      ProductListItem(crypto, index,
                                          onTap: () => _onCurrencyClicked(
                                              context,
                                              crypto[index].urlSymbol)),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                ),
                              )),
                  ],
                );
              } else if (state is CryptoListError) {
                return ShowErrorWidget(
                  state.errorMessage,
                  onPressed: () =>
                      context.read<CryptoListBloc>().add(OnLoadCryptoList()),
                );
              }
              return ProgressIndicatorWidget();
            }),
          ),
        ),
      ]),
    );
  }

  _onCurrencyClicked(BuildContext context, String crypto) async {
    final route = Utils.getRoute1(context, MySearchPage(crypto));
    await Navigator.push(context, route);
    context.read<CryptoListBloc>().add(OnRefreshCryptoList());
  }
}
