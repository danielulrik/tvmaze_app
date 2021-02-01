import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class NetworkService {
  static Dio _dio;

  static BaseOptions _baseOptions = new BaseOptions(
    baseUrl: 'http://api.tvmaze.com/',
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  static final instance = NetworkService._();

  NetworkService._() {
    this._init();
  }

  _init() {
    if (_dio == null) {
      _dio = Dio(_baseOptions);

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  Future<dynamic> request(HttpMethod method, String endpoint,
      {Map headers, body, @required bool ignoreInterceptor}) async {
    dynamic response;

    try {
      if (method == HttpMethod.GET) {
        response = await this._get(endpoint,
            headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.POST) {
        response = await this._post(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PUT) {
        response = await this._put(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PATCH) {
        response = await this._patch(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.DELETE) {
        response = await this._delete(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else {
        print('HttpMethod unknown!');
      }
    } catch (e) {
      print("Exception Request => ($method) => ${_dio.options.baseUrl}$endpoint");
      if (body != null) print('Exception Body => ${jsonEncode(body) ?? ''}');
      print('Exception Headers => ${e.request.headers}');
      print('Exception => ${e.toString()}');

      if (e is DioError) {
        var dioError = e;
        print('Exception Dio => ${dioError.response}');

        if (dioError.response.statusCode == 300) {
          // Multiple Choices
          return dioError.response.data['data'];
        }

        String message = dioError?.response?.data['data'];
        if (message != null) {
          print('message -> $message');
          throw new Exception(message);
        } else {
          throw new Exception('Unknown error!');
        }
      } else {
        throw new Exception(
            'Fail to do the request! Try again later.');
      }
    }

    return response;
  }

  Future<dynamic> _get(String endpoint,
      {Map headers, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Check your connection!');
    }

    Response response = await _dio.get(
      endpoint,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _post(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Check your connection!');
    }

    Response response = await _dio.post(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _put(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Check your connection!');
    }

    Response response = await _dio.put(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _patch(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Check your connection!');
    }

    Response response = await _dio.patch(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _delete(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Check your connection!');
    }

    Response response = await _dio.delete(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> customPost(String endpoint, {Map headers, body}) async {
    if (!await this.isConnected()) {
      throw new Exception('Unknown error!');
    }

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};

    dynamic response;

    try {
      response = await _dio.post(
        endpoint,
        data: body,
        options: options,
      );
    } catch (e) {
      print("Exception Request => (POST) => $endpoint");
      if (body != null) print('Exception Body => ${jsonEncode(body) ?? ''}');
      print('Exception Headers => ${e.request.headers}');
      print('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        print('Exception Dio => ${dioError.message}');
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception('Unknown error!');
        }
      } else {
        throw new Exception(
            'Fail to do the request! Try again later.');
      }
    }

    print('Request Headers => ${response.request.headers}');
    print("Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      print("${jsonEncode(response.request.data) ?? ''}");
    print("Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response;
  }

  Future<dynamic> customGet(String endpoint, {Map headers}) async {
    if (!await this.isConnected()) {
      throw new Exception('Check your connection!');
    }

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};
    // options.headers = headers;

    dynamic response;
    try {
      response = await _dio.get(
        endpoint,
        options: options,
      );
    } catch (e) {
      print(e);
      print("Exception Request => (GET) => $endpoint");
      print('Exception Headers => ${e.request.headers}');
      print('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        print('Exception Dio => ${dioError.message}');
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Fail to do the request! Try again later.');
        }
      } else {
        throw new Exception(
            'Fail to do the request! Try again later.');
      }
    }

    print('Request Headers => ${response.request.headers}');
    print("Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      print("${jsonEncode(response.request.data) ?? ''}");
    print("Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response.data;
  }

  dynamic _generateResponse(Response response) {
    if (response == null) {
      print('404 - Response null');
      throw new Exception(
          'Fail to do the request! Try again later.');
    }

    final int statusCode = response.statusCode;

    print('Request Headers => ${response.request.headers}');
    print("Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      print("${jsonEncode(response.request.data) ?? ''}");
    print("Response ($statusCode) => ${jsonEncode(response.data)}");

    final decoded = response.data;

    if (statusCode < 200 || statusCode > 204) {
      if (decoded != null) {
        throw new Exception(decoded);
      }
      throw new Exception(
          'Fail to do the request! Try again later.');
    }
    if (decoded == null) return null;
    if (decoded is List) {
      return decoded;
    } else if (decoded is Map) {
      if (decoded != null) {
        return decoded;
      } else if (decoded.isNotEmpty) {
        return decoded;
      } else {
        return null;
      }
    }
    if (decoded is String && decoded.isEmpty)
      return null;
    else {
      return decoded;
    }
  }

  Future<Options> _getCustomConfig(
      Map<String, String> customHeader, bool ignoreInterceptor) async {
    Options options = Options();
    options.extra = {'ignoreInterceptor': ignoreInterceptor};
    options.headers = await this._getDefaultHeader(customHeader);
    return options;
  }

  Future<Map<String, String>> _getDefaultHeader(
      Map<String, String> customHeader) async {
    Map<String, String> header = {"Content-Type": "application/json"};

    if (customHeader != null) {
      header.addAll(customHeader);
    }

    return header;
  }

  /// ==========================================================
  /// Extras

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> azureUpload(String uuid, String session, File anexo) async {
    var accountName = 'uniddevstlrsuseaslocavia';
    var containerName = 'anexosfrota360';

    var encodedName = Uri.encodeComponent(path.basename(anexo.path));

    var url =
        'https://$accountName.blob.core.windows.net/$containerName/$uuid?$session';

    var data = anexo.readAsBytesSync();

    print('URL -> $url');

    try {
      var putUri = Uri.parse(url);
      var request = new http.Request(
        'PUT',
        putUri,
      );
      request.headers['Content-Type'] = 'application/octet-stream';
      request.headers['x-ms-blob-type'] = 'BlockBlob';
      request.headers['x-ms-blob-content-disposition'] =
          'attachment; filename="$encodedName"';
      request.headers['x-ms-blob-content-type'] = lookupMimeType(anexo.path);

      request.bodyBytes = data;

      var response = await request.send();
      print('UPLOAD RESPONSE -> ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode <= 204)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      throw new Exception('ERRO UPLOAD: $e');
    }
  }

  Future<dynamic> multipartFile(String url, File customFile,
      {Map headers, encoding, String fileName}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão e tente novamente!');
    }
    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest('POST', postUri);
    request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    request.files.add(new http.MultipartFile.fromBytes(
        'image', await customFile.readAsBytes(),
        filename: fileName ?? 'image', contentType: MediaType('image', 'jpg')));

    return request.send().then((response) async {
      print("Request (MultipartFile): $url");
      print("Response Code: ${response.statusCode}");
      if (response.statusCode < 200 || response.statusCode > 204) {
        throw new Exception('Erro desconhecido!');
      } else {
        print("Uploaded!");
        var a = await response.stream.bytesToString();
        Map map = json.decode(a);
        return map['data'];
      }
    });
  }
}
