import 'package:bloc_ecommerce/common/widgets/custom_image_widget.dart';
import 'package:bloc_ecommerce/core/theme/style.dart';
import 'package:bloc_ecommerce/core/theme/theme.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/widgets/quantity_button_widget.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final ProductsEntity product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(color: context.color.border),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Column(children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                ),
                child: CustomImage(
                  image: '', height: 80, width: 80,
                ),
              ),

              if(double.tryParse(product.stockQty ?? '0')?.toInt() == 0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Text('Stock Out!', style: fontRegular.copyWith(
                        color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                      )),
                    ),
                  ),
                ),
            ]),
            SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Text('${double.tryParse(product.stockQty ?? '0')?.toInt()}'),
            SizedBox(width:80, child: Divider(color: Colors.grey.shade400, height: 1)),
          ]),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(product.name ?? ''),
                if(product.notes != null && product.notes!.isNotEmpty)
                  Text(product.notes ?? ''),
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${product.price ?? ''}',
                      style: fontRegular.copyWith(color: context.color.primary),
                    ),
                    TextSpan(
                      text: '    ||    ',
                      style: fontRegular.copyWith(color: context.color.primary),
                    ),
                    TextSpan(
                      text: '${product.unitQty ?? ''} ${product.unitName ?? ''}',
                      style: fontRegular.copyWith(color: context.color.primary),
                    ),
                  ],
                )),
                Text('Master Pack : ${product.packSize ?? ''}'),
                Text(product.categoryName ?? ''),

                QuantityButtonWidget(product: product),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
