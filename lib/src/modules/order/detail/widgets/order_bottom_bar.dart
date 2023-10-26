import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dtos/order/order_dto.dart';
import '../../../../models/orders/order_status.dart';
import '../../order_controller.dart';

final class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;

  const OrderBottomBar({
    required this.controller,
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _OrderBottomBarButtom(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Colors.blue,
          image: 'assets/images/icons/finish_order_white_ico.png',
          buttonLabel: 'Finalizar',
          onPressed: order.status == OrderStatus.confirmed
              ? () => controller.changeStatus(OrderStatus.finished)
              : null,
        ),
        _OrderBottomBarButtom(
          borderRadius: BorderRadius.zero,
          color: Colors.green,
          image: 'assets/images/icons/confirm_order_white_icon.png',
          buttonLabel: 'Confirmar',
          onPressed: order.status == OrderStatus.pending
              ? () => controller.changeStatus(OrderStatus.confirmed)
              : null,
        ),
        _OrderBottomBarButtom(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.red,
          image: 'assets/images/icons/cancel_order_white_icon.png',
          buttonLabel: 'Cancelar',
          onPressed: order.status != OrderStatus.cancelled &&
                  order.status != OrderStatus.finished
              ? () => controller.changeStatus(OrderStatus.cancelled)
              : null,
        ),
      ],
    );
  }
}

final class _OrderBottomBarButtom extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color color;
  final String image;
  final String buttonLabel;
  final VoidCallback? onPressed;

  const _OrderBottomBarButtom({
    required this.borderRadius,
    required this.color,
    required this.image,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            side: onPressed != null ? BorderSide(color: color) : null,
            backgroundColor: color,
          ),
          child: Row(
            children: [
              Image.asset(image),
              const SizedBox(width: 5),
              Text(
                buttonLabel,
                style:
                    context.textStyles.textBold.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
