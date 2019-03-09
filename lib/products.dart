import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  // Constructor shortcut to automatically bind the parameter to class property.
  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products
          .map(
            (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/food.jpg'),
                      Text(element)
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}
