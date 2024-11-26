import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import 'order_controller.dart';
import 'widgets/order_detail_modal.dart';
import 'widgets/order_header.dart';
import 'widgets/order_item.dart';

final class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

final class _OrderPageState extends State<OrderPage>
    with Loader<OrderPage>, Messages<OrderPage> {
  late final OrderController _controller;
  late final ReactionDisposer _disposer;

  void _showOrderDetail() => showDialog<void>(
        context: context,
        builder: (_) => OrderDetailModal(
          controller: _controller,
          order: _controller.selectedOrder!,
        ),
      );

  @override
  void initState() {
    super.initState();
    _controller = context.read<OrderController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _disposer = reaction((_) => _controller.status, (status) {
        switch (status) {
          case OrderStateStatus.initial:
            break;
          case OrderStateStatus.loading:
            showLoader();
          case OrderStateStatus.error:
            hideLoader();
            showError(_controller.errorMessage ?? 'Erro ao buscar pedidos');
          case OrderStateStatus.success:
            hideLoader();
          case OrderStateStatus.showDetailModal:
            hideLoader();
            _showOrderDetail();
          case OrderStateStatus.statusChanged:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            _controller.findOrders();
        }
      });
      _controller.findOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          OrderHeader(controller: _controller),
          Expanded(
            child: Observer(
              builder: (_) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  mainAxisExtent: 91,
                ),
                itemBuilder: (_, index) =>
                    OrderItem(order: _controller.orders[index]),
                itemCount: _controller.orders.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
