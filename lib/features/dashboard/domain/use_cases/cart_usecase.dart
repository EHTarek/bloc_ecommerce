import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/cart_products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

final class AddToCart {
  final DashboardRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, List<CartProductsEntity>>> call(CartProductsEntity product) {
    return repository.addToCart(product.toJson());
  }
}

final class RemoveFromCart {
  final DashboardRepository repository;

  RemoveFromCart(this.repository);

  Future<Either<Failure, List<CartProductsEntity>>> call(int productId) {
    return repository.removeFromCart(productId);
  }
}

final class ClearCart {
  final DashboardRepository repository;

  ClearCart(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.clearCart();
  }
}

final class LoadCart {
  final DashboardRepository repository;

  LoadCart(this.repository);

  Future<Either<Failure, List<CartProductsEntity>>> call() {
    return repository.loadCart();
  }
}