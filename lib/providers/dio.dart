import 'package:anime_slayer/consts/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/custom_logger.dart';
import 'shared_pref.dart';
import 'token_controller.dart';







final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = EndPoints.prodBaseUrl;
  dio.options.connectTimeout = const Duration(seconds: 5000);
  dio.options.receiveTimeout = const Duration(seconds: 3000);
  dio.options.headers = {
    'contentType': 'application/json; charset=UTF-8',
  };
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true));
  return dio;
});

final dioClientProvider = Provider<DioClient>((ref) {
  ref.onDispose(() {
    // ref.read(dioProvider).close(force: true);
  });
  final dio = ref.watch(dioProvider);
  dio.interceptors.add(AuthInterceptor(ref));

  return DioClient(dio);
});

class DioClient {
  final Dio dio;
  DioClient(this.dio);

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(String path,
      {Map<String, dynamic>? queryParameters,
      required data,
      contentType = Headers.jsonContentType}) async {
    try {
      final response = await dio.post(path,
          queryParameters: queryParameters,
          data: data,
          options: Options(contentType: contentType));
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> put(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data}) async {
    try {
      final response =
          await dio.put(path, queryParameters: queryParameters, data: data);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> patch(String path,
      {Map<String, dynamic>? queryParameters,
      required Map<String, dynamic> data}) async {
    try {
      final response =
          await dio.patch(path, queryParameters: queryParameters, data: data);
      return response;
    } on DioException {
      rethrow;
    }
  }
}

class AuthInterceptor extends Interceptor {
  final Ref ref;
  AuthInterceptor(this.ref) {
    init();
  }

  void init() {
    token = ref.read(tokenProvider);
    ref.listen(tokenProvider, (previous, next) {
      token = next;
    });
  }

  String? token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      AppLogger.logDebug('Token: $token');
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response!.isUnauthorized) {
    } else if (err.response!.isForbidden) {}
    super.onError(err, handler);
  }
}


extension ResponseX on Response {
  mapTo<T>(T Function(Map<String, dynamic> json) fromJson) {
    return fromJson(data);
  }

  T mapToList<T>(T Function(List<dynamic> json) fromJson) {
    return fromJson(data);
  }

  bool get isSuccessful => statusCode! >= 200 && statusCode! < 300;

  bool get isUnauthorized => statusCode == 401;

  bool get isForbidden => statusCode == 403;

  void throwIfNotSuccessful() {
    if (!isSuccessful) {
      throw DioException(
        response: this,
        error: 'Request failed with status code $statusCode',
        requestOptions: requestOptions,
      );
    }
  }

  String? get errorMessage {
    if (data is Map<String, dynamic>) {
      return data['message'] as String?;
    }
    return null;
  }

  String get token {
    if (data is Map<String, dynamic>) {
      return data['token'] as String;
    }
    return '';
  }
}

