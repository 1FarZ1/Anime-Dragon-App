



import 'package:anime_slayer/consts/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_pref.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final dioClientProvider = Provider<DioClient>((ref) => DioClient(
    ref.watch(dioProvider),
    ref.watch(sharedPrefProvider).requireValue,
    null
    // ref.watch(tokenProvider)
    
    ));

class DioClient {
  final Dio _dio;
  final SharedPreferences pref;
  final String? token;

  DioClient(this._dio, this.pref, this.token) {
    // AppLogger.logInfo('Got token: $token');

    _dio.options.baseUrl = EndPoints.prodBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5000);
    _dio.options.receiveTimeout = const Duration(seconds: 3000);
    _dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(String path,
      {Map<String, dynamic>? queryParameters, required data, contentType = Headers.jsonContentType}) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(contentType:contentType)
      );
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
          await _dio.put(path, queryParameters: queryParameters, data: data);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
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
          await _dio.patch(path, queryParameters: queryParameters, data: data);
      return response;
    } on DioException {
      rethrow;
    }
  }
}


