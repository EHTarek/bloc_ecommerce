import 'package:bloc_ecommerce/common/widgets/custom_snackbar_widget.dart';
import 'package:bloc_ecommerce/core/theme/style.dart';
import 'package:bloc_ecommerce/core/theme/theme.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/widgets/quantity_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutDialogWidget extends StatelessWidget {
  const CheckoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is CartUpdated,
      builder: (context, cartState) {
        double totalAmount = 0;

        if (cartState is CartUpdated) {
          for (final product in cartState.cart) {
            totalAmount += (double.tryParse(product.product?.price ?? '0') ?? 0) * (product.quantity ?? 1);
          }

          return AlertDialog(
            contentPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            title: Text('Confirm Checkout', style: fontBold.copyWith(
              fontSize: 20,
              color: Colors.black,
            ), textAlign: TextAlign.center),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                minHeight: MediaQuery.of(context).size.height * 0.3,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...cartState.cart.map((product) => Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                        tileColor: Colors.grey.shade100,
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: RichText(text: TextSpan(
                            text: product.product?.name ?? '',
                            style: fontRegular.copyWith(color: Colors.black),
                            children: [
                              TextSpan(text: product.product?.name ?? ''),
                              TextSpan(text: ' (${product.quantity} x \$${product.product?.price})'),
                            ],
                          )),
                        ),
                        trailing: context.read<CartCubit>().isCheckoutCartEditing ? InkWell(
                          onTap: () {
                            context.read<CartCubit>().removeFromCart(
                              int.parse(product.product?.id.toString() ?? '0'),
                            );
                          },
                          child: Icon(Icons.delete_forever_sharp),
                        ) : Text('\$${product.product?.price}', style: fontMedium),
                        subtitle: context.read<CartCubit>().isCheckoutCartEditing
                            ? QuantityButtonWidget(product: product.product!)
                            : null,
                      ),
                    )),
                    Divider(color: Colors.grey.shade300),

                    ListTile(
                      textColor: Colors.red,
                      tileColor: Colors.grey.shade200,
                      title: Text('Total', style: fontMedium),
                      trailing: Text('\$$totalAmount', style: fontMedium),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              if (cartState.cart.isNotEmpty)...[
                TextButton(
                  onPressed: () {
                    context.read<CartCubit>().toggleCheckoutCartEditing();
                  },
                  child: Text(
                    context.watch<CartCubit>().isCheckoutCartEditing ? 'Cancel Edit' : 'Edit',
                    style: fontBold.withColor(Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<CartCubit>().cartCheckout(carts: cartState.cart);
                    context.pop();
                  },
                  child: Text('Checkout', style: fontBold.withColor(Colors.teal)),
                ),
              ],

              if (cartState.cart.isEmpty)...[
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text('Close', style: fontBold.withColor(Colors.red)),
                ),
              ],

            ],
          );
        }

        return Text('No items in cart', style: fontMedium);
      },
    );
  }
}
