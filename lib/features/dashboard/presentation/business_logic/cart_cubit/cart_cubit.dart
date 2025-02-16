import 'package:bloc_ecommerce/core/error/failure.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/cart_products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/use_cases/cart_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCart addToCartUseCase;
  final RemoveFromCart removeFromCartUseCase;
  final LoadCart loadCartUseCase;
  final ClearCart clearCartUseCase;

  CartCubit({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.loadCartUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    final Either<Failure, List<CartProductsEntity>> result = await loadCartUseCase();

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartProducts) => emit(CartUpdated(cartProducts)),
    );
  }

  Future<void> addToCart(CartProductsEntity product) async {
    emit(CartLoading());
    final Either<Failure, List<CartProductsEntity>> result = await addToCartUseCase(product);

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartProducts) => emit(CartUpdated(cartProducts)),
    );
  }

  Future<void> removeFromCart(int productId) async {
    emit(CartLoading());
    final Either<Failure, List<CartProductsEntity>> result = await removeFromCartUseCase(productId);

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartProducts) => emit(CartUpdated(cartProducts)),
    );
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    final Either<Failure, void> result = await clearCartUseCase();

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => emit(CartUpdated([])),
    );
  }
}
