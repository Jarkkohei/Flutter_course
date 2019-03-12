import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue;
  String descriptionValue;
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product title'),
            onChanged: (String value) {
              setState(() {
                titleValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product description'),
            maxLines: 5,
            onChanged: (String value) {
              setState(() {
                descriptionValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product price'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                priceValue = double.parse(value);
              });
            },
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Theme.of(context).primaryColorLight,
            child: Text('Save'), 
            onPressed: () {
            final Map<String, dynamic> product = {
              'title': titleValue, 
              'description': descriptionValue, 
              'price': priceValue,
              'image': 'assets/food.jpg'
            };
            widget.addProduct(product);
          }),
        ],
      ),
    );
  }
}
