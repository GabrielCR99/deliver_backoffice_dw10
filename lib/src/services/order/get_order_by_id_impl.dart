import '../../dtos/order/order_dto.dart';
import '../../dtos/order/order_product_dto.dart';
import '../../models/orders/order_model.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
import '../../repositories/products/products_repository.dart';
import '../../repositories/user/user_repository.dart';
import 'get_order_by_id.dart';

final class GetOrderByIdImpl implements GetOrderById {
  final PaymentTypeRepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductsRepository _productsRepository;

  const GetOrderByIdImpl({
    required PaymentTypeRepository paymentTypeRepository,
    required UserRepository userRepository,
    required ProductsRepository productsRepository,
  })  : _paymentTypeRepository = paymentTypeRepository,
        _userRepository = userRepository,
        _productsRepository = productsRepository;

  @override
  Future<OrderDto> call(OrderModel order) async => _orderDtoParser(order);

  Future<OrderDto> _orderDtoParser(OrderModel order) async {
    final paymentType = _paymentTypeRepository.findById(order.paymentTypeId);
    final user = _userRepository.findById(order.userId);
    final products = _orderProductsParser(order);

    final responses = await Future.wait([paymentType, user, products]);

    return OrderDto(
      id: order.id,
      date: order.date,
      status: order.status,
      products: responses[2] as List<OrderProductDto>,
      user: responses[1] as UserModel,
      address: order.address,
      cpf: order.cpf,
      paymentType: responses.first as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDto>> _orderProductsParser(OrderModel order) async {
    final orderProducts = <OrderProductDto>[];
    final productsFuture =
        order.products.map((e) => _productsRepository.findById(e.productId));

    final products = await Future.wait(productsFuture);

    for (var i = 0; i < order.products.length; i++) {
      final orderProduct = order.products[i];
      final productDto = OrderProductDto(
        product: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );

      orderProducts.add(productDto);
    }

    return orderProducts;
  }
}
