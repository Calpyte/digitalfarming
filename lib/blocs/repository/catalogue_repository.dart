import 'package:digitalfarming/blocs/client/catalogue_client.dart';
import 'package:digitalfarming/models/catalogue.dart';
import 'package:digitalfarming/resources/result.dart';

class CatalogueRepository {
  CatalogueRepository({CatalogueClient? client}) {
    _client = client ?? CatalogueClient();
  }

  CatalogueClient _client = CatalogueClient();

  Future<Result<List<Catalogue>>> getCatalogues() async {
    return _client.getCatalogues();
  }
}
