import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product title'),
      //autovalidate: true,
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        /*if(value.trim().length <= 0) {
          return 'Title is required';
        }*/
        if (value.isEmpty || value.length < 3) {
          return 'Title is required and should be at least 3 characters long.';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product description'),
      maxLines: 5,
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Description is required and should be at least 5 characters long.';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      initialValue:
          product == null ? '' : product.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          textColor: Theme.of(context).primaryColorLight,
          child: Text('Save'),
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(height: 10.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Product product = new Product(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image']);

    if (selectedProductIndex == null) {
      addProduct(product);
    } else {
      updateProduct(product);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent = _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit product'),
            ),
            body: pageContent
          );
      },
    );
  }
}
