//import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/connected_products.dart';
import '../models/user.dart';

mixin UserModel on ConnectedProducts {

  void login(String email, String password) {
    authenticatedUser = User(
      id: 'fdsgfdgfd', 
      email: email, 
      password: password,
    );
  }
}