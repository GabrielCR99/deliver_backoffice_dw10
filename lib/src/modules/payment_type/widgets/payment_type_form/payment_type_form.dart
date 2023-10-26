import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_controller.dart';

final class PaymentTypeForm extends StatefulWidget {
  final PaymentTypeModel? model;
  final PaymentTypeController controller;

  const PaymentTypeForm({
    required this.model,
    required this.controller,
    super.key,
  });

  @override
  State<PaymentTypeForm> createState() => _PaymentTypeFormState();
}

final class _PaymentTypeFormState extends State<PaymentTypeForm> {
  final _nameEC = TextEditingController();
  final _acronymEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _enabled = false;

  void _closeModal() => Navigator.of(context).pop();

  @override
  void initState() {
    super.initState();
    final paymentModel = widget.model;

    if (paymentModel != null) {
      _nameEC.text = paymentModel.name;
      _acronymEC.text = paymentModel.acronym;
      _enabled = paymentModel.enabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        width: screenWidth * (screenWidth > 1200 ? 0.5 : 0.7),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      widget.model == null
                          ? 'Adicionar'
                          : 'Editar forma de pagamento',
                      style: context.textStyles.titleText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: _closeModal,
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameEC,
                decoration: const InputDecoration(label: Text('Nome')),
                validator: Validatorless.required('Nome obrigatório'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _acronymEC,
                decoration: const InputDecoration(label: Text('Sigla')),
                validator: Validatorless.required('Sigla obrigatória'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Ativo', style: context.textStyles.textRegular),
                  Switch(
                    value: _enabled,
                    onChanged: (value) => setState(() => _enabled = value),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 60,
                    child: OutlinedButton(
                      onPressed: _closeModal,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.textExtraBold
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: _onPressedsavePayment,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedsavePayment() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      final name = _nameEC.text;
      final acronym = _acronymEC.text;

      widget.controller.savePayment(
        id: widget.model?.id,
        name: name,
        acronym: acronym,
        enabled: _enabled,
      );
    }
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _acronymEC.dispose();
    super.dispose();
  }
}
