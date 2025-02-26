import 'dart:async';

import 'package:bloc_ecommerce/common/widgets/custom_snackbar_widget.dart';
import 'package:bloc_ecommerce/common/widgets/custom_textfield_widget.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/cart_products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityButtonWidget extends StatefulWidget {
  final ProductsEntity product;
  const QuantityButtonWidget({super.key, required this.product});

  @override
  State<QuantityButtonWidget> createState() => _QuantityButtonWidgetState();
}

class _QuantityButtonWidgetState extends State<QuantityButtonWidget> {
  late TextEditingController _quantityController;
  int _quantity = 0;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '1');
    context.read<CartCubit>().loadCart();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is CartUpdated,
      builder: (context, state) {
        if(state is CartUpdated){

          final cartItem = state.cart.firstWhere(
                (item) => item.productId == widget.product.id,
            orElse: () => CartProductsEntity(productId: widget.product.id!, quantity: 0, product: widget.product),
          );
          _quantity = cartItem.quantity ?? 0;
          _quantityController.text = _quantity.toString();

          return _quantity == 0 ? Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () => addToCart(1),
              icon: const Icon(CupertinoIcons.cart),
            ),
          ) : Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                SizedBox(
                  width: 100,
                  child: CustomTextField(
                    controller: _quantityController,
                    hintText: 'Qty',
                    labelText: 'Qty',
                    showLabelText: false,
                    isNumber: true,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.done,
                    onChanged: (_) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(Duration(milliseconds: 500), () {
                        final newQuantity = int.tryParse(_quantityController.text) ?? 0;
                        addToCart(newQuantity);
                      });
                    },
                    onSubmit: () {
                      final newQuantity = int.tryParse(_quantityController.text) ?? 0;
                      addToCart(newQuantity);
                    },
                  ),
                ),

                IconButton(
                  onPressed: () {
                    if (_quantity > 1) {
                      addToCart(_quantity - 1);
                    }else{
                      context.read<CartCubit>().removeFromCart(widget.product.id!);
                    }
                  },
                  icon: Icon(_quantity > 1 ? CupertinoIcons.minus_circle : CupertinoIcons.delete),
                ),

                Center(child: Text('$_quantity')),

                IconButton(
                  onPressed: () => addToCart(_quantity + 1),
                  icon: const Icon(CupertinoIcons.add_circled),
                ),

              ],
            ),
          );
        }

        return Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () => addToCart(1),
            icon: const Icon(CupertinoIcons.cart),
          ),
        );
      },
    );
  }

  void addToCart(int qty) {
    if((double.tryParse(widget.product.stockQty ?? '0')?.toInt() ?? 0) >= qty){
      context.read<CartCubit>().addToCart(
        CartProductsEntity(
          productId: widget.product.id!,
          quantity: qty,
          product: widget.product,
        ),
      );
    }else{
      showCustomSnackBar('Out of stock');
    }
  }
}