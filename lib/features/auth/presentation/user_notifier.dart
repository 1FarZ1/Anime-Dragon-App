import 'dart:convert';
import 'package:anime_slayer/features/auth/data/auth_repository.dart';
import 'package:anime_slayer/utils/custom_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/token_controller.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    final token = ref.watch(tokenProvider);

    return UserNotifier(ref.watch(authRepositoryProvider), token);
  },
);

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this.authRepository, this.token)
      : super(const UserState.initial()) {
    if (token == null) {
      clearUser();
    } else {
      _getUser();
    }
  }

  final String? token;
  final AuthRepository authRepository;

  _getUser() async {
    final user = await authRepository.fetchUserInfo();
    AppLogger.logInfo('UserNotifier user: $user');
    state = state.copyWith(user: user);
  }

  // // set User
  // void setUser(UserModel user) {
  //   state = state.copyWith(user: user);
  // }

  // clear User
  void clearUser() async {
    state = const UserState.initial();
    await authRepository.logout();
  }
}

class UserState {
  final UserModel? userData;

  const UserState({this.userData});

  const UserState.initial() : userData = null;

  get isLoggedIn => userData != null;

  UserState copyWith({
    UserModel? user,
  }) {
    return UserState(
      userData: user ?? userData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': userData?.toMap(),
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      userData: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserState.fromJson(String source) =>
      UserState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserState(user: $userData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState && other.userData == userData;
  }

  @override
  int get hashCode => userData.hashCode;
}

class UserModel {
  final String email;
  final String avatar;
  final String name;
  UserModel({
    required this.email,
    required this.avatar,
    required this.name,
  });

  UserModel copyWith({
    String? email,
    String? avatar,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
    );
  }

  factory UserModel.empty() {
    return UserModel(email: '', avatar: '', name: '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'avatar': avatar,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      avatar: map['avatar'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel( email: $email, avatar: $avatar, name: $name)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.avatar == avatar && other.name == name;
  }

  @override
  int get hashCode {
    return email.hashCode ^ avatar.hashCode ^ name.hashCode;
  }
}
