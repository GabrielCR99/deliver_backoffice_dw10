import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dtos/order/order_dto.dart';
import '../detail/widgets/order_bottom_bar.dart';
import '../detail/widgets/order_info_tile.dart';
import '../detail/widgets/order_product_item.dart';
import '../order_controller.dart';

final class OrderDetailModal extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;

  const OrderDetailModal({
    required this.controller,
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;

    return Material(
      color: Colors.black26,
      child: Dialog(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.all(30),
          width: screenWidth * (screenWidth > 1200 ? 0.5 : 0.7),
          child: ListView(
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      'Detalhes do pedido',
                      style: context.textStyles.titleText,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Nome do cliente: ', style: context.textStyles.textBold),
                  const SizedBox(width: 20),
                  Text(order.user.name, style: context.textStyles.textRegular),
                ],
              ),
              const Divider(),
              ...order.products
                  .map((product) => OrderProductItem(product: product)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total do pedido',
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 18),
                    ),
                    Text(
                      order.products
                          .fold<double>(
                            0,
                            (previousValue, element) =>
                                previousValue + element.totalPrice,
                          )
                          .currencyPtBr,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(),
              OrderInfoTile(label: 'Endereço de entrega', info: order.address),
              const Divider(),
              OrderInfoTile(
                label: 'Forma de pagamento',
                info: order.paymentType.name,
              ),
              const SizedBox(height: 10),
              OrderBottomBar(controller: controller, order: order),
            ],
          ),
        ),
      ),
    );
  }
}
