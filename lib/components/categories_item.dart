import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
  final String data;
  CategoriesItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        label: Text("$data"),
      ),
    );
  }
}
