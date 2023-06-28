import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import 'payment_type_controller.dart';
import 'widgets/payment_type_form/payment_type_form.dart';
import 'widgets/payment_type_header.dart';
import 'widgets/payment_type_item.dart';

class PaymentTypePage extends StatefulWidget {
  const PaymentTypePage({super.key});

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage>
    with Loader<PaymentTypePage>, Messages<PaymentTypePage> {
  late final PaymentTypeController _controller;
  final _disposers = <ReactionDisposer>[];

  void _showAddOrUpdatePayment() => showDialog<void>(
        context: context,
        builder: (_) => Material(
          color: Colors.black26,
          child: Dialog(
            backgroundColor: Colors.white,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: PaymentTypeForm(
              model: _controller.selectedPaymentType,
              controller: _controller,
            ),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _controller = context.read<PaymentTypeController>();
    scheduleMicrotask(() {
      final filterDisposer = reaction(
        (_) => _controller.filterEnabled,
        (_) => _controller.getPayments(),
      );
      final statusDisposer = reaction((_) => _controller.status, (status) {
        switch (status) {
          case PaymentTypeStateStatus.initial:
            break;
          case PaymentTypeStateStatus.loading:
            showLoader();
          case PaymentTypeStateStatus.error:
            hideLoader();
            showError(
              _controller.errorMessage ?? 'Erro ao buscar tipos de pagamento',
            );
          case PaymentTypeStateStatus.success:
            hideLoader();
          case PaymentTypeStateStatus.addOrUpdatePayment:
            hideLoader();
            _showAddOrUpdatePayment();
          case PaymentTypeStateStatus.saved:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            _controller.getPayments();
        }
      });
      _disposers.addAll([statusDisposer, filterDisposer]);
      _controller.getPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      color: Colors.grey[50],
      child: Column(
        children: [
          PaymentTypeHeader(controller: _controller),
          const SizedBox(height: 50),
          Observer(
            builder: (_) => Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 680,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 120,
                ),
                itemBuilder: (context, index) {
                  final paymentTypeModel = _controller.paymentTypes[index];

                  return PaymentTypeItem(
                    paymentType: paymentTypeModel,
                    controller: _controller,
                  );
                },
                itemCount: _controller.paymentTypes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }
}
