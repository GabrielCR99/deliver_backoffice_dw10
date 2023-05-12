import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../detail/widgets/order_bottom_bar.dart';
import '../detail/widgets/order_info_tile.dart';
import '../detail/widgets/order_product_item.dart';

class OrderDetailModal extends StatelessWidget {
  const OrderDetailModal({super.key});

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
                  Text('Gabriel', style: context.textStyles.textRegular),
                ],
              ),
              const Divider(),
              ...List.generate(3, (index) => const OrderProductItem()),
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
                      200.0.currencyPtBr,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const OrderInfoTile(
                label: 'Endereço de entrega',
                info: 'Rua 1, 123',
              ),
              const Divider(),
              const OrderInfoTile(
                label: 'forma de pagamento',
                info: 'Dinheiro',
              ),
              const SizedBox(height: 10),
              const OrderBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
