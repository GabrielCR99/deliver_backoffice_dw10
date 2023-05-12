import 'package:flutter/material.dart';

import '../../../../core/extensions/formatter_extension.dart';
import '../../../../core/ui/styles/text_styles.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({super.key});

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
          Text('X-Tudão', style: context.textStyles.textRegular),
          Text('1', style: context.textStyles.textRegular),
          Expanded(
            child: Text(
              100.0.currencyPtBr,
              style: context.textStyles.textRegular,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
