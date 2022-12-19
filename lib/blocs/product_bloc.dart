import 'dart:async';

import 'package:digitalfarming/blocs/repository/product_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class ProductBloc {
  final logger = AppLogger.get('CountryBloc');
  final ProductRepository _productRepository = ProductRepository();

  final StreamController<Result> _productController =
      StreamController<Result>();

  StreamSink get productSink => _productController.sink;
  Stream<Result> get productStream => _productController.stream;

  Future<void> getProducts() async {
    productSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response = await _productRepository.getProduct();
    productSink.add(response);
  }

  void dispose() {
    _productController.close();
  }
}
