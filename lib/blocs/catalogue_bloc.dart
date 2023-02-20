import 'dart:async';

import 'package:digitalfarming/blocs/repository/catalogue_repository.dart';
import 'package:digitalfarming/blocs/repository/product_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/catalogue.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class CatalogueBloc {
  final logger = AppLogger.get('CatalogueBloc');
  final CatalogueRepository _catalogueRepository = CatalogueRepository();

  final StreamController<Result> _catalogueController =
      StreamController<Result>();

  StreamSink get catalogueSink => _catalogueController.sink;
  Stream<Result> get catalogueStream => _catalogueController.stream;

  Future<void> getCatalogues() async {
    catalogueSink.add(Result.loading(Constants.LOADING));
    final Result<List<Catalogue>> response =
        await _catalogueRepository.getCatalogues();
    catalogueSink.add(response);
  }

  void dispose() {
    _catalogueController.close();
  }
}
