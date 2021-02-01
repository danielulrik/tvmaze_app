import 'dart:io';

import 'package:tvmaze_app/services/network_service.dart';


class ApiBase {
  final _network = NetworkService.instance;

  Future<dynamic> request(
    HttpMethod method,
    String endpoint, {
    Map headers,
    body,
    bool cacheFirst = false,
    bool ignoreInterceptor = false,
  }) {
    return _network
        .request(method, endpoint,
            headers: headers, body: body, ignoreInterceptor: ignoreInterceptor)
        .then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> customGet(
    String url, {
    Map headers,
  }) async {
    return _network.customGet(url, headers: headers);
  }

  Future<dynamic> multipartFile(
    String url,
    File customFile, {
    Map headers,
    encoding,
    String fileName,
  }) async {
    return _network.multipartFile(url, customFile, fileName: fileName);
  }

}
