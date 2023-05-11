import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../payment_type_controller.dart';

class PaymentTypeHeader extends StatefulWidget {
  final PaymentTypeController controller;

  const PaymentTypeHeader({required this.controller, super.key});

  @override
  State<PaymentTypeHeader> createState() => _PaymentTypeHeaderState();
}

class _PaymentTypeHeaderState extends State<PaymentTypeHeader> {
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'ADMINISTRAR FORMAS DE PAGAMENTO',
      onSearch: (value) {},
      buttonLabel: 'ADICIONAR',
      onButtonTap: widget.controller.addPayment,
      filterWidget: DropdownButton<bool>(
        items: const [
          DropdownMenuItem(child: Text('Todos')),
          DropdownMenuItem(value: true, child: Text('Ativo')),
          DropdownMenuItem(value: false, child: Text('Inativo')),
        ],
        value: enabled,
        onChanged: (value) => setState(() {
          enabled = value;
          widget.controller.filter = value;
        }),
      ),
    );
  }
}
