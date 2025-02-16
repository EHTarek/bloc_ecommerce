import 'dart:convert';

import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/features/dashboard/data/models/cart_products_model.dart';

abstract class DashboardLocalDataSource {
  Future<List<CartProductsModel>> addToCart(Map<String, dynamic> product);
  Future<List<CartProductsModel>> removeFromCart(int productId);
  Future<List<CartProductsModel>> loadCart();
  Future<void> clearCart();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final Preferences prefs;

  DashboardLocalDataSourceImpl({required this.prefs});

  @override
  Future<List<CartProductsModel>> addToCart(Map<String, dynamic> product) async {
    final cart = await loadCart();
    final cartProductsModel = CartProductsModel.fromJson(product);

    final productIndex = cart.indexWhere((item) => item.productId == cartProductsModel.productId);
    if (productIndex != -1) {
      cart[productIndex].quantity = cartProductsModel.quantity;
    } else {
      cart.add(cartProductsModel);
    }
    await _saveCart(cart);
    return cart;
  }

  Future<void> _saveCart(List<CartProductsModel> cart) async {
    final cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
    await prefs.setStringValue(keyName: PreferencesKey.kCartProducts, value: cartJson);
  }

  @override
  Future<void> clearCart() async {
    await prefs.clearOne(keyName: PreferencesKey.kCartProducts);
  }

  @override
  Future<List<CartProductsModel>> loadCart() async {
    final cartJson = prefs.getStringValue(keyName: PreferencesKey.kCartProducts);
    if (cartJson.isEmpty) return [];

    final List<dynamic> jsonList = jsonDecode(cartJson);
    return jsonList.map((json) => CartProductsModel.fromJson(json)).toList();
  }

  @override
  Future<List<CartProductsModel>> removeFromCart(int productId) async {
    final cart = await loadCart();
    cart.removeWhere((item) => item.productId == productId);
    await _saveCart(cart);
    return cart;
  }
}
