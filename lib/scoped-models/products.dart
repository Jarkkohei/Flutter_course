import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

import '../scoped-models/connected_products.dart';

mixin ProductsModel on ConnectedProducts {
  
  
  bool _showFavorites = false;

  // Getter for the products list.
  List<Product> get allProducts {
    // Create new list not just a pointer.
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if(_showFavorites == true) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if(selectedProductIndex == null) {
      return null;
    }
    return products[selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  

  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
      title: title, 
      description: description, 
      image: image, 
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );

    products[selectedProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
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
    //_products[_selectedProductIndex] =updatedProduct;
    //_selectedProductIndex = null;
    //notifyListeners();
    updateProduct(updatedProduct);
    selProductIndex = null;
  }

  void selectProduct(int index) {
    selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}