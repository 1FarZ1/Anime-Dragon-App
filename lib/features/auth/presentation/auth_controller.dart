import 'package:anime_slayer/features/auth/presentation/user_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dio.dart';
import '../data/auth_repository.dart';
import '../data/requests/login_request_model.dart';
import '../data/remote_auth_data_source.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    repository: ref.watch(authRepositoryProvider),
    userNotifier: ref.watch(userProvider.notifier),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required this.repository,
    required this.userNotifier,
    required this.ref,
  }) : super(const AuthState.initial());

  final AuthRepository repository;
  final UserNotifier userNotifier;
  final Ref ref;
  Future<void> login({required LoginRequestModel data}) async {
    state = const AuthState.loading();
    try {
      final response = await repository.login(data: data);
      //TODO
      // ref.read(tokenProvider.notifier).update((state) => response.data['access_token'] );
      userNotifier.getUser();
      state = const AuthState.success();
    } on DioException catch (e) {
      state = AuthState.error('Failed to login');
    } catch (e) {
      state = AuthState.error('Failed to login');
    }
  }

  Future<void> register({required RegisterRequestModel data}) async {
    state = const AuthState.loading();
    try {
      await repository.register(data: data);
      userNotifier.getUser();

      state = const AuthState.success();
    } on DioException catch (e) {
      state = AuthState.error('Failed to register');
    } catch (e) {
      state = AuthState.error('Failed to register');
    }
  }

  // Future<void> logout() async {
  //   state = const AuthState.loading();
  //   try {
  //     // final response = await remoteDataSource.logout();
  //     await repository.localDataSource.deleteToken();
  //     state = const AuthState.initial();
  //   } catch (e) {
  //     state = AuthState.error('Failed to logout');
  //   }
  // }
}

class AuthState {
  // contain all important things that we need to know about the state
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.error,
  });

  const AuthState.initial() : this();

  const AuthState.loading() : this(isLoading: true);

  const AuthState.success() : this();

  AuthState.error(String error) : this(error: error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => isLoading.hashCode ^ error.hashCode;

  @override
  String toString() => 'AuthS tate(isLoading: $isLoading, error: $error)';
 
  AuthState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
