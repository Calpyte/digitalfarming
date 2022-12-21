import 'package:digitalfarming/resources/app_logger.dart';
import 'package:http_interceptor/http_interceptor.dart';

///
/// Interceptor for debug purpose.
///
class LogInterceptor implements InterceptorContract {
  final logger = AppLogger.get('LogInterceptor');

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    printRequestLog(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    printResponseLog(data);
    return data;
  }

  void printRequestLog(RequestData data) {
    logger.d('Method: ${data.method}');
    logger.d('Url: ${data.url}');
    logger.d('Body: ${data.body}');
    logger.d('Headers: ${data.headers}');
   // logger.d('Authorization: ${data.headers['authorization']}');
  }

  void printResponseLog(ResponseData data) {
   /* logger.d('Status Code: ${data.statusCode}');
    logger.d('Method: ${data.method}');
    logger.d('Url: ${data.url}');
    logger.d('Body: ${data.body}');
    logger.d('Headers: ${data.headers}');*/
  }
}
