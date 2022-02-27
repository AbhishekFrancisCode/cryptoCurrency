import 'package:cryptodata/components/presentation/bloc/order_book_bloc.dart';
import 'package:cryptodata/components/presentation/widgets/order_book_list.dart';
import 'package:cryptodata/components/presentation/widgets/progress_indicator_widget.dart';
import 'package:cryptodata/components/presentation/widgets/show_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowHideDemo extends StatefulWidget {
  final String searchTerm;
  const ShowHideDemo(this.searchTerm);

  @override
  _ShowHideDemoState createState() {
    return _ShowHideDemoState(this.searchTerm);
  }
}

class _ShowHideDemoState extends State<ShowHideDemo> {
  bool _isVisible = false;
  String searchTerm;
  _ShowHideDemoState(this.searchTerm);

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // var time = const Duration();
  //  Timer.periodic(time, (timer) => {}
  //  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderBookBloc(searchTerm)..add(OnOrderBook(searchTerm)),
      child:
          BlocBuilder<OrderBookBloc, OrderBookState>(builder: (context, state) {
        if (state is OrderBookLoaded) {
          context.read<OrderBookBloc>().add(OnRefreshProductList());
          final list = state.list;
          final product = list;
          return Container(
            // color: Colors.blueGrey,
            child: state.isLoading
                ? ProgressIndicatorWidget()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: showToast,
                              child: _isVisible == false
                                  ? Text("VIEW ORDER BOOK")
                                  : Text("HIDE ORDER BOOK")),
                        ),
                      ),
                      Visibility(
                          visible: _isVisible,
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("BID PRICE"),
                                  Text("      QTY     "),
                                  Text("      QTY     "),
                                  Text("ASK PRICE"),
                                ]),
                            SizedBox(height: 30),
                            ListView.separated(
                              itemBuilder: (BuildContext, index) {
                                return OrderBookListItem(
                                    product, searchTerm, index);
                              },
                              itemCount: 5,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => Divider(),
                            ),
                          ]))
                    ],
                  ),
          );
        } else if (state is OrderBookError) {
          return ShowErrorWidget(
            state.errorMessage,
            onPressed: () =>
                context.read<OrderBookBloc>().add(OnOrderBook(searchTerm)),
          );
        }
        return Container();
      }),
    );
  }
}
