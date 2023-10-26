import 'package:flutter/material.dart';

import '../../../../core/extensions/formatter_extension.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dtos/order/order_product_dto.dart';

final class OrderProductItem extends StatelessWidget {
  final OrderProductDto product;

  const OrderProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: Colors.grey[300]!)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(product.product.name, style: context.textStyles.textRegular),
          Text('${product.amount}', style: context.textStyles.textRegular),
          Expanded(
            child: Text(
              product.totalPrice.currencyPtBr,
              style: context.textStyles.textRegular,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
