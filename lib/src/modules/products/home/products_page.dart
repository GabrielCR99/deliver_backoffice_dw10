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
  final _controller = Modular.get<ProductsController>();
  final _debouncer = Debouncer(milliseconds: 500);
  late final ReactionDisposer _disposer;

  Future<void> _onButtontap() async {
    await Navigator.of(context).pushNamed('./product-detail');
    _controller.getProducts();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _disposer = reaction((p0) => _controller.status, (status) {
        switch (status) {
          case ProductStateStatus.initial:
          case ProductStateStatus.loading:
            showLoader();
          case ProductStateStatus.success:
            hideLoader();
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao buscar os produtos');
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
            onSearch: (value) =>
                _debouncer(() => _controller.filterByName(value)),
            buttonLabel: 'ADICIONAR PRODUTO',
            onButtonTap: _onButtontap,
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
