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

  void addProduct(Product product) {
    _products.add(product);
  }

  void updateProduct(int index, Product product) {
    _products[index] = product;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
  }
}