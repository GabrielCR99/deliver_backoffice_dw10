import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/payment_type_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';

part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  success,
  error,
  addOrUpdatePayment,
  saved,
}

final class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract interface class PaymentTypeControllerBase with Store {
  @readonly
  PaymentTypeModel? _selectedPaymentType;

  @readonly
  var _status = PaymentTypeStateStatus.initial;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  String? _errorMessage;

  @readonly
  bool? _filterEnabled;

  final PaymentTypeRepository _paymentTypeRepository;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  set filter(bool? enabled) => _filterEnabled = enabled;

  @action
  Future<void> getPayments() async {
    _status = PaymentTypeStateStatus.loading;

    try {
      _paymentTypes =
          await _paymentTypeRepository.findAll(enabled: _filterEnabled);
      _status = PaymentTypeStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar os tipos de pagamento', error: e, stackTrace: s);

      _errorMessage = 'Erro ao buscar os tipos de pagamento';
      _status = PaymentTypeStateStatus.error;
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    await Future<void>.delayed(Duration.zero);
    _selectedPaymentType = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  Future<void> editPayment(PaymentTypeModel model) async {
    _status = PaymentTypeStateStatus.loading;
    await Future<void>.delayed(Duration.zero);
    _selectedPaymentType = model;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    required String name,
    required String acronym,
    required bool enabled,
    int? id,
  }) async {
    _status = PaymentTypeStateStatus.loading;
    final paymentTypeModel = PaymentTypeModel(
      name: name,
      acronym: acronym,
      enabled: enabled,
      id: id,
    );

    await _paymentTypeRepository.save(paymentTypeModel);
    _status = PaymentTypeStateStatus.saved;
  }
}
