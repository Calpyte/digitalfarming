import 'dart:async';

import 'package:digitalfarming/blocs/repository/country_repository.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class CountryBloc {
  final logger = AppLogger.get('CountryBloc');
  final CountryRepository _countryRepository = CountryRepository();

  final StreamController<Result> _countryController = StreamController<Result>();

  StreamSink get countrySink => _countryController.sink;
  Stream<Result> get countryStream => _countryController.stream;


  Future<void> getCountries() async {
    countrySink.add(Result.loading(Constants.LOADING));
    final Result<List<Country>>? response =
    await _countryRepository.getCountries();
    countrySink.add(response);
  }

  void dispose() {
    _countryController.close();
  }

}