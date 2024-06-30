import 'package:anime_slayer/features/auth/presentation/user_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/local_auth_data_source.dart';
import 'requests/login_request_model.dart';
import 'remote_auth_data_source.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remoteDataSource: ref.watch(remoteAuthDataSourceProvider),
    localDataSource: ref.watch(localAuthDataSourceProvider),
  );
});

class AuthRepository {
  final RemoteAuthDataSource remoteDataSource;
  final LocalAuthDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Response> login({required LoginRequestModel data}) async {
    try {
      final response = await remoteDataSource.login(data: data);

      final token = response.data['access_token'] as String;
      localDataSource.saveToken(token);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to login');
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<Response> register({required RegisterRequestModel data}) async {
    try {
      final response = await remoteDataSource.register(data: data);
      final token = response.data['access_token'] as String;
      localDataSource.saveToken(token);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to register');
    } catch (e) {
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    try {
      localDataSource.clearToken();
    } catch (e) {
      rethrow;
    }
  }

  String? getToken() {
    try {
      final token = localDataSource.getToken();
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future fetchUserInfo() async {
    try {
      final response = await remoteDataSource.fetchUserInfo();
      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      }
    } catch (e) {
      //TODO
      print('no data then');
    }
  }


  // Future<User> updateProfile({required UpdateProfileRequestModel data}) async {
  //   try {
  //     final response = await remoteDataSource.updateProfile(data: data);
  //     final user = User.fromJson(response.data);
  //     return user;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> changePassword(
  //     {required String oldPassword, required String newPassword}) async {
  //   try {
  //     final response = await remoteDataSource.changePassword(
  //         data: ChangePasswordRequest(
  //             oldPassword: oldPassword, newPassword: newPassword));
  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to change password');
  //     }
  //   } catch (e) {
  //     throw CustomException(ExeptionCodes.somethingWentWrong);
  //   }
  // }

  // // forget password init
  // Future<void> forgetPasswordInit({required String email}) async {
  //   try {
  //     final response = await remoteDataSource.forgetPasswordInit(email: email);
  //     if (response.statusCode == 400) {
  //       throw CustomException(ExeptionCodes.emailNotExist);
  //     }
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 500) {
  //       throw CustomException(ExeptionCodes.internalServerError);
  //     }
  //     if (e.response?.statusCode == 400) {
  //       throw CustomException(ExeptionCodes.emailNotExist);
  //     }
  //     throw CustomException(ExeptionCodes.somethingWentWrong);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // // verify verification code
  // Future<void> verifyVerificationCode(
  //     {required String email, required String code}) async {
  //   try {
  //     final response = await remoteDataSource.verifyVerificationCode(
  //         data: VerifyCodeRequest(email: email, code: code));
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 500) {
  //       throw CustomException(ExeptionCodes.internalServerError);
  //     }
  //     if (e.response?.statusCode == 400) {
  //       throw CustomException(ExeptionCodes.incorrectCode);
  //     }
  //     throw CustomException(ExeptionCodes.somethingWentWrong);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // // reset password
  // Future<void> resetPassword(
  //     {required String email,
  //     required String code,
  //     required String password}) async {
  //   try {
  //     final response = await remoteDataSource.resetPassword(
  //         data: ResetPasswordRequest(
  //             email: email, code: code, password: password));
  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to reset password');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Response> verifyToken({required String token}) async {
  //   try {
  //     final response = await remoteDataSource.verifyToken(token: token);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
