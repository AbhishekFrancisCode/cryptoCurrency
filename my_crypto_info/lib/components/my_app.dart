import 'package:cryptodata/components/presentation/pages/start_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp() {
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyStartPage(),
    );
  }
}
