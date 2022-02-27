import 'package:cryptodata/components/presentation/bloc/order_book_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderBookBloc(searchTerm)..add(OnOrderBook(searchTerm)),
      child:
          BlocBuilder<OrderBookBloc, OrderBookState>(builder: (context, state) {
        if (state is OrderBookLoaded) {
          final list = state.list;
          return Container(
            color: Colors.blueGrey,
            child: state.isLoading
                ? ProgressIndicatorWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: showToast,
                            child: Text("VIEW ORDER BOOK")),
                        Visibility(
                            visible: _isVisible,
                            child: ListTile(
                                      leading: Text('${list.bids[0]}',
                                    style: TextStyle(color: Colors.green),
                                  ))
                                ),
                        // SizedBox(
                        //   height: 35,
                        // ),
                      ],
                    ),
                  ),
          );
        } else if (state is OrderBookError) {
          return ShowErrorWidget(
            state.errorMessage,
            onPressed: () =>
                context.read<OrderBookBloc>().add(OnOrderBook(searchTerm)),
          );
        }
        return ProgressIndicatorWidget();
      }),
    );
  }
}
