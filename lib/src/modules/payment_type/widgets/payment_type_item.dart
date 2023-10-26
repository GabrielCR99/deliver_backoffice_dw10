import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import '../payment_type_controller.dart';

final class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel paymentType;

  const PaymentTypeItem({
    required this.paymentType,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorAll = paymentType.enabled ? Colors.black : Colors.grey;

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${paymentType.acronym}_icon.png',
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/icons/payment_notfound_icon.png',
                color: colorAll,
              ),
              color: colorAll,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Forma de pagamento',
                      style: context.textStyles.textRegular
                          .copyWith(color: colorAll),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Text(
                      paymentType.name,
                      style: context.textStyles.titleText
                          .copyWith(color: colorAll),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: paymentType.enabled
                      ? () => controller.editPayment(paymentType)
                      : null,
                  child: Text(
                    'Editar',
                    style: context.textStyles.textMedium.copyWith(
                      color: paymentType.enabled
                          ? context.appColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
