

import 'package:fetch_product/product_page.dart';
import 'package:flutter/material.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(),
    );
  }
}