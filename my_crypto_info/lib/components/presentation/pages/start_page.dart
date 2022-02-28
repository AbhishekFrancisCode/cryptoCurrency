import 'package:cryptodata/components/presentation/pages/quick_search_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptodata/components/presentation/widgets/progress_indicator_widget.dart';
import 'package:cryptodata/components/presentation/widgets/show_error_widget.dart';

import '../bloc/start_page_bloc.dart';

// ignore: must_be_immutable
class MyStartPage extends StatelessWidget {
  int _currentIndex = 0;
  final List<Widget> _children = [MyCryptoListPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<StartBloc>(
        create: (context) => StartBloc()..add(OnLoadStart(_currentIndex)),
        child: BlocBuilder<StartBloc, StartState>(
          builder: (context, state) {
            if (state is StartLoading) {
              return Scaffold(
                body: _children[_currentIndex],
              );
            } else if (state is StartError) {
              return ShowErrorWidget(
                state.errorMessage,
                onPressed: () =>
                    context.read<StartBloc>().add(OnLoadStart(_currentIndex)),
              );
            }
            return ProgressIndicatorWidget();
          },
        ),
      ),
    );
  }
}
