import 'package:cryptodata/components/data/models/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductListItem extends StatelessWidget {
  final position;
  final List<CryptoList> list;
  final VoidCallback onTap;
  const ProductListItem(this.list, this.position, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#a0bcd6"),
      alignment: Alignment.center,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 40,
            minHeight: 40,
            maxWidth: 40,
            maxHeight: 40,
          ),
          child: Image.asset("./assets/image/Cryptocurrency_Logo.png",
              fit: BoxFit.cover),
        ),
        title: Text("${list[position].urlSymbol}"),
        subtitle: Text("${list[position].description}"),
        onTap: onTap,
      ),
    );
  }
}
