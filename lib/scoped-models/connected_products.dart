import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/product.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  bool _isLoading = false;
  final String firebaseProjectUrl = '<YOUR_FIREBASE_PROJECT_URL_HERE>';
  
  Future<Null> addProduct(
      String title, String description, String image, double price) {
        _isLoading = true;
        notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': 'https://images.pexels.com/photos/65882/chocolate-dark-coffee-confiserie-65882.jpeg?cs=srgb&dl=dessert-macro-sweets-65882.jpg&fm=jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };

    return http.post(firebaseProjectUrl + '/products.json',
        body: json.encode(productData)).then((http.Response response) {
          final Map<String, dynamic> responseData = json.decode(response.body);
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
          _isLoading = false;
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
      id: selectedProduct.id,
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

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http.get(firebaseProjectUrl + '/products.json')
      .then((http.Response response) {
        final List<Product> fetchedProductList = [];
        final Map<String, dynamic> productListData = json.decode(response.body);
        if(productListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }
        productListData.forEach((String productId, dynamic productData) {
          final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId:productData['userId'],
          );
          fetchedProductList.add(product);
        });
        _products = fetchedProductList;
        _isLoading = false;
        notifyListeners();
      });
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final newFavoriteStatus = !isCurrentlyFavorite;

    final Product updatedProduct = Product(
      id: selectedProduct.id,
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

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
