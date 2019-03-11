import 'package:flutter/material.dart';

import'./product_create.dart';
import'./product_list.dart';

class ProductsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              text: 'Create product',
              icon: Icon(Icons.create),
            ),
            Tab(
              text: 'My products',
              icon: Icon(Icons.list),
            ),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductCreatePage(),
            ProductListPage(),
          ],
        ),
      ),
    );
  }
}
