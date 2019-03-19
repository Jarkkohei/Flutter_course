import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  // Getter for the products list.
  List<Product> get products {
    // Create new list not just a pointer.
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if(_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
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
      isFavorite: newFavoriteStatus
    );
    //_products[_selectedProductIndex] =updatedProduct;
    //_selectedProductIndex = null;
    //notifyListeners();
    updateProduct(updatedProduct);
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }
}