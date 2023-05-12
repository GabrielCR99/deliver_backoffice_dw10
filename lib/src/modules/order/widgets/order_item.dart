import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/orders/order_model.dart';
import '../order_controller.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return InkWell(
      onTap: () => context.read<OrderController>().showDetailModal(),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text('Pedido ', style: textStyles.textBold),
                    Text('${order.id}', style: textStyles.textExtraBold),
                    Expanded(
                      child: Text(
                        order.status.name,
                        style: textStyles.textExtraBold
                            .copyWith(color: order.status.color, fontSize: 20),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(width: 5, height: double.infinity),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
