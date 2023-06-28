import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/helpers/debouncer.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/widgets/base_header.dart';
import 'products_controller.dart';
import 'widgets/product_item.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with Loader<ProductsPage>, Messages<ProductsPage> {
  late final ProductsController _controller;
  final _debouncer = Debouncer(milliseconds: 500);
  late final ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _controller = context.read<ProductsController>();
    scheduleMicrotask(() {
      _disposer = reaction((_) => _controller.status, (status) async {
        switch (status) {
          case ProductStateStatus.initial:
            break;
          case ProductStateStatus.loading:
            showLoader();
          case ProductStateStatus.success:
            hideLoader();
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao buscar os produtos');
          case ProductStateStatus.addOrUpdateProduct:
            hideLoader();
            var uri = './product-detail';
            final selectedProduct = _controller.selectedProduct;
            if (selectedProduct != null) {
              uri += '?id=${selectedProduct.id}';
            }
            await Navigator.of(context).pushNamed(uri);
            _controller.getProducts();
        }
      });
      _controller.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      color: Colors.grey[50],
      child: Column(
        children: [
          BaseHeader(
            title: 'ADMINISTRAR PRODUTOS',
            onButtonTap: _controller.addProduct,
            buttonLabel: 'ADICIONAR PRODUTO',
            onSearch: (value) =>
                _debouncer(() => _controller.filterByName(value)),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Observer(
              builder: (_) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 280,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (_, index) =>
                    ProductItem(product: _controller.products[index]),
                itemCount: _controller.products.length,
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
