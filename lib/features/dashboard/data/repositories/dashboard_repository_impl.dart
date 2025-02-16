import 'package:bloc_ecommerce/core/error/exception.dart';
import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:bloc_ecommerce/core/extra/network_info.dart';
import 'package:bloc_ecommerce/features/dashboard/data/data_source/dashboard_local_data_source.dart';
import 'package:bloc_ecommerce/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/cart_products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final NetworkInfo networkInfo;
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts() async{
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getProducts());
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, List<CartProductsEntity>>> addToCart(Map<String, dynamic> product) async {
    if (await networkInfo.isConnected) {
      try {
        final cartProducts = await localDataSource.addToCart(product);
        return Right(cartProducts.map((model) => model.toEntity()).toList());
        // return Right(await localDataSource.addToCart(product));
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await localDataSource.clearCart());
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, List<CartProductsEntity>>> loadCart() async {
    if (await networkInfo.isConnected) {
      try {
        final cartProducts = await localDataSource.loadCart();
        return Right(cartProducts.map((model) => model.toEntity()).toList());

        // return Right(await localDataSource.loadCart());
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, List<CartProductsEntity>>> removeFromCart(int productId) async {
    if (await networkInfo.isConnected) {
      try {
        final cartProducts = await localDataSource.removeFromCart(productId);
        return Right(cartProducts.map((model) => model.toEntity()).toList());

        // return Right(await localDataSource.removeFromCart(productId));
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, String>> cartCheckout(List<Map<String, dynamic>> carts) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.cartCheckout(carts));
      } on UnauthorizedException {
        return const Left(TokenInvalid(message: 'Invalid Token'));
      } catch (_) {
        return const Left(ServerFailure(message: 'Something went wrong!'));
      }
    } else {
      return const Left(ConnectionFailure(message: 'No Internet Connection!'));
    }
  }
}
