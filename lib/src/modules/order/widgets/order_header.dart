import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../../../models/orders/order_status.dart';
import '../order_controller.dart';

final class OrderHeader extends StatefulWidget {
  final OrderController controller;
  const OrderHeader({required this.controller, super.key});

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

final class _OrderHeaderState extends State<OrderHeader> {
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
          widget.controller.changeStatusFilter(value);
          _selectedStatus = value;
        }),
      ),
    );
  }
}
