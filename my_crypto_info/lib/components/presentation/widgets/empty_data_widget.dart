import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;

  EmptyDataWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 8, color: HexColor("#a0bcd6")),
        ));
  }
}
