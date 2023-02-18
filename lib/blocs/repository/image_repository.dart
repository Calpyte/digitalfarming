import 'package:digitalfarming/blocs/client/image_client.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
  ImageRepository({ImageClient? client}) {
    _client = client ?? ImageClient();
  }

  ImageClient _client = ImageClient();


  Future<Result<String>> savePhoto({required XFile photo}) async {
      return _client.savePhoto(photo: photo);
  }

}