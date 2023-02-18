import 'dart:async';

import 'package:digitalfarming/blocs/repository/image_repository.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImageBloc {
  final logger = AppLogger.get('ImageBloc');
  final ImageRepository _imageRepository = ImageRepository();

  final StreamController<Result> _imageController = StreamController<Result>();

  StreamSink get imageSink => _imageController.sink;
  Stream<Result> get imageStream => _imageController.stream;

  Future<void> savePhoto({required XFile photo}) async {
    imageSink.add(Result.loading(Constants.LOADING));
    final Result<String> response =
        await _imageRepository.savePhoto(photo: photo);
    imageSink.add(Result.completed(response));
  }

  void dispose() {
    _imageController.close();
  }
}
