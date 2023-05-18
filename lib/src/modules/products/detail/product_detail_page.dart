import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/env/env.dart';
import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/helpers/upload_html_helper.dart';
import '../../../core/ui/styles/text_styles.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;

  const ProductDetailPage({this.productId, super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with Loader<ProductDetailPage>, Messages<ProductDetailPage> {
  late final _controller = context.read<ProductDetailController>();
  final _nameEC = TextEditingController();
  final _priceEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reaction((_) => _controller.status, (status) {
        switch (status) {
          case ProductDetailStateStatus.initial:
          case ProductDetailStateStatus.loading:
            showLoader();

          case ProductDetailStateStatus.success:
            final model = _controller.productModel!;
            _nameEC.text = model.name;
            _priceEC.text = model.price.currencyPtBr;
            _descriptionEC.text = model.description;
            hideLoader();

          case ProductDetailStateStatus.error:
            hideLoader();
            showError(_controller.errorMessage ?? 'Erro ao buscar o produto');

          case ProductDetailStateStatus.errorLoadingProduct:
            hideLoader();
            showError(_controller.errorMessage ?? 'Erro ao buscar o produto');
            Navigator.of(context).pop();

          case ProductDetailStateStatus.deleted:
          case ProductDetailStateStatus.saved:
            hideLoader();
            Navigator.of(context).pop();
            break;
          case ProductDetailStateStatus.uploaded:
            hideLoader();
        }
      });
      _controller.loadProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonActionWidth = context.percentWidth(0.4);

    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey[50],
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.productId != null ? 'Alterar' : 'Adicionar'} '
                    'Produto',
                    style: context.textStyles.titleText.copyWith(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    '/products',
                    ModalRoute.withName('/'),
                  ),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Observer(
                      builder: (_) {
                        if (_controller.imagePath != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.network(
                              '${Env.instance.get('backend_base_url')}'
                              '${_controller.imagePath}',
                              width: 200,
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () => UploadHtmlHelper()
                            .startUpload(_controller.uploadImageProduct),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                        ),
                        child: Observer(
                          builder: (_) => Text(_addOrRemovePicture),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameEC,
                        decoration: const InputDecoration(label: Text('Nome')),
                        validator: Validatorless.required('Nome obrigatório'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _priceEC,
                        decoration: const InputDecoration(label: Text('Preço')),
                        validator: Validatorless.required('Preço obrigatório'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionEC,
              decoration: const InputDecoration(
                label: Text('Descrição'),
                alignLabelWithHint: true,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 10,
              validator: Validatorless.required('Descrição obrigatória'),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: buttonActionWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: buttonActionWidth / 2,
                      height: 60,
                      child: Visibility(
                        visible: widget.productId != null,
                        child: OutlinedButton(
                          onPressed: () => showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirmar'),
                              content: Text(
                                'Deseja realmente deletar o produto '
                                '${_controller.productModel?.name}?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Cancelar',
                                    style: context.textStyles.textBold
                                        .copyWith(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _onPressedDeleteProduct,
                                  child: Text(
                                    'Confirmar',
                                    style: context.textStyles.textBold
                                        .copyWith(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: Text(
                            'Deletar',
                            style: context.textStyles.textBold
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: buttonActionWidth / 2,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _onPressedSaveProduct,
                        child: Text(
                          'Salvar',
                          style: context.textStyles.textBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedDeleteProduct() {
    _controller.deleteProduct();
    Navigator.of(context).pop();
  }

  String get _addOrRemovePicture =>
      '${_controller.imagePath == null ? 'Adicionar' : 'Alterar'} foto';

  void _onPressedSaveProduct() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      if (_controller.imagePath == null) {
        showWarning(
          'Selecione uma imagem para o produto',
        );

        return;
      }
      _controller.save(
        name: _nameEC.text,
        price: UtilBrasilFields.converterMoedaParaDouble(
          _priceEC.text,
        ),
        description: _descriptionEC.text,
      );
    }
  }
}
