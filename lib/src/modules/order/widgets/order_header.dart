import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../../../models/orders/order_status.dart';

class OrderHeader extends StatefulWidget {
  const OrderHeader({super.key});

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrderStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Administrar Pedidos',
      showAddButton: false,
      filterWidget: DropdownButton<OrderStatus>(
        items: [
          const DropdownMenuItem(child: Text('Todos')),
          ...OrderStatus.values
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
        ],
        value: _selectedStatus,
        onChanged: (value) => setState(() {
          _selectedStatus = value;
        }),
      ),
    );
  }
}
