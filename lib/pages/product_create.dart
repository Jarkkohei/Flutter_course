import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
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
    return Column(
      padding: EdgeInsets.all,
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              titleValue = value;
            });
          },
        ),
        TextField(
          maxLines: 5,
          onChanged: (String value) {
            setState(() {
              descriptionValue = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              priceValue = double.parse(value);
            });
          },
        ),
      ],
    );
  }
}
