import 'package:cryptodata/components/data/models/crypto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListItem extends StatelessWidget {
  final position;
  final CryptoList product;
  final VoidCallback onTap;
  final String called;
  final ValueChanged<int> onVariantPositionChanged;
  const ProductListItem(this.product, this.position,
      {this.onTap, this.onVariantPositionChanged, this.called});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Wrap(children: [
        Card(
          child: Text('${product.urlSymbol}',
              style: GoogleFonts.josefinSans(fontSize: 22),
              textAlign: TextAlign.center),
        ),
      ]),
    );
  }
}
