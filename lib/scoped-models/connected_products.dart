import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/product.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': 'https://images.pexels.com/photos/65882/chocolate-dark-coffee-confiserie-65882.jpeg?cs=srgb&dl=dessert-macro-sweets-65882.jpg&fm=jpg',
      'price': price,
    };

    http.post('<YOUR_FIREBASE_PROJECT_URL_HERE>',
        body: json.encode(productData)).then((http.Response response) {
          final Map<String, dynamic> responseData = json.decode(response.body)
          final Product newProduct = Product(
            id: responseData['name'],
            title: title,
            description: description,
            image: image,
            price: price,
            userEmail: _authenticatedUser.email,
            userId: _authenticatedUser.id,
          );
          _products.add(newProduct);
          //_selProductIndex = null;
          notifyListeners();
        }
      );
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  // Getter for the products list.
  List<Product> get allProducts {
    // Create new list not just a pointer.
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites == true) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );

    _products[selectedProductIndex] = updatedProduct;
    //_selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    //_selProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final newFavoriteStatus = !isCurrentlyFavorite;

    final Product updatedProduct = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
      isFavorite: newFavoriteStatus,
    );
    _products[_selProductIndex] = updatedProduct;
    //_selProductIndex = null;
    notifyListeners();
    //_selProductIndex = null;
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(
      id: 'fdsgfdgfd',
      email: email,
      password: password,
    );
  }
}
