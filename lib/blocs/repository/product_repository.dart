import 'package:digitalfarming/blocs/client/product_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';

class ProductRepository {
  ProductRepository({ProductClient? client}) {
    _client = client ?? ProductClient();
  }

  ProductClient _client = ProductClient();

  Future<Result<List<Basic>>> getProduct() async {
    return await _client.getProduct();
  }
}
