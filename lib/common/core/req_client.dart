import 'package:dio/dio.dart';

class ReqClient {
  Dio dio = Dio();

  Future<Response> getWithoutHeaderClient(url) async {
    return await dio.get(url,
        options: Options(
          headers: {
            // 'Accept': '*/*',
          },
        ));
  }
}
