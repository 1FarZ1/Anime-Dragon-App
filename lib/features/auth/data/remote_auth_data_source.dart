import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../providers/dio.dart';
import '../../../consts/endpoints.dart';
import 'login_request_model.dart';

final remoteAuthDataSourceProvider = Provider<RemoteAuthDataSource>((ref) {
  return RemoteAuthDataSource(dioClient: ref.watch(dioClientProvider));
});

class RegisterRequestModel {
  String username;
  String email;
  String password;
  XFile avatar;

  RegisterRequestModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.avatar});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": username,
      "email": email,
      "password": password,
      "avatar": MultipartFile.fromFileSync(avatar.path),
    };
  }
}

class RemoteAuthDataSource {
  final DioClient _dioClient;

  RemoteAuthDataSource({required dioClient}) : _dioClient = dioClient;

  Future<Response> login({required LoginRequestModel data}) async {
    final response = await _dioClient.post(
      EndPoints.login,
      data: data.toJson(),
    );
    return response;
  }

  Future<Response> register({required RegisterRequestModel data}) async {
    final formData = FormData.fromMap(data.toMap());
    final response = await _dioClient.post(EndPoints.register,
        data: formData, contentType: Headers.multipartFormDataContentType);
    return response;
  }

  Future<Response> fetchUserInfo() async {
    final response = await _dioClient.get(
      EndPoints.userInfo,
    );
    return response;
  }

  // Future<Response> updateProfile(
  //     {required UpdateProfileRequestModel data}) async {
  //   final response = await _dioClient.patch(
  //     EndPoints.updateProfile,
  //     data: data.toMap(),
  //   );
  //   return response;
  // }

  // Future<Response> changePassword({required ChangePasswordRequest data}) async {
  //   final response = await _dioClient.post(
  //     EndPoints.changePassword,
  //     data: data.toMap(),
  //   );
  //   return response;
  // }

  // Future<Response> forgetPasswordInit({required String email}) async {
  //   final response = await _dioClient.post(
  //     EndPoints.forgotPassword,
  //     data: {"email": email},
  //   );
  //   return response;
  // }

  // Future<Response> verifyVerificationCode(
  //     {required VerifyCodeRequest data}) async {
  //   final response = await _dioClient.post(
  //     EndPoints.verifyCode,
  //     data: data.toMap(),
  //   );
  //   return response;
  // }

  // Future<Response> resetPassword({required ResetPasswordRequest data}) async {
  //   final response = await _dioClient.post(
  //     EndPoints.resetPassword,
  //     data: data.toMap(),
  //   );
  //   return response;
  // }

  // Future<Response> verifyToken({required String token}) async {
  //   final response = await _dioClient.post(
  //     EndPoints.verifyToken,
  //     data: jsonEncode({"token": token}),
  //   );
  //   return response;
  // }
}
