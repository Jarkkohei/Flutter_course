import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage(this.title, this.imageUrl, this.price, this.description);

  Widget _buildAddressPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Rautatientori, Helsinki',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$ ' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.red),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //print('Back button pressed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(title),
            ),
            _buildAddressPriceRow(),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
