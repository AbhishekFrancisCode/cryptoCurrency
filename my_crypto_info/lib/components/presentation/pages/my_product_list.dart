import 'package:cryptodata/components/presentation/bloc/product_list_bloc.dart';
import 'package:cryptodata/components/presentation/pages/my_search.dart';
import 'package:cryptodata/components/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class MyCryptoListPage extends StatelessWidget {
  MyCryptoListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Crypto Data"),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: SearchWidget(
          onTextChanged: (searchTerm) {
            Utils.navigateToPage(context, MySearchPage(searchTerm));
          },
        ),
      ),
    );
  }
}
