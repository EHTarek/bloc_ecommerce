import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/cart_products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/products_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<ProductsEntity>>> getProducts();
  Future<Either<Failure, List<CartProductsEntity>>> addToCart(Map<String, dynamic> product);
  Future<Either<Failure, List<CartProductsEntity>>> removeFromCart(int productId);
  Future<Either<Failure, List<CartProductsEntity>>> loadCart();
  Future<Either<Failure, void>> clearCart();
  Future<Either<Failure, String>> cartCheckout(List<Map<String, dynamic>> carts);
}
