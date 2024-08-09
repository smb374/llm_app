part of '../models.dart';

// User
// User
@JsonSerializable(checked: true)
class User with EquatableMixin {
  final String? uuid;
  final String name;
  final String email;

  User(this.uuid, this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    final user = _$UserFromJson(json);

    if (user.uuid != null && !Uuid.isValidUUID(fromString: user.uuid!)) {
      throw Exception('Failed to parse user: Invalid uuid');
    }

    return user;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [uuid, name, email];
}

// UserLoginResponse
@JsonSerializable(checked: true)
class UserLoginResponse with EquatableMixin {
  final String token;

  @JsonKey(name: 'refreshtoken')
  final String refreshToken;

  UserLoginResponse(this.token, this.refreshToken);

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);

  @override
  List<Object?> get props => [token, refreshToken];
}

// UserRegisterResponse
class UserRegisterResponse with EquatableMixin {
  @override
  List<Object?> get props => [];
}

// UserRefreshResponse
@JsonSerializable(checked: true)
class UserRefreshResponse with EquatableMixin {
  @JsonKey(name: 'new_token')
  final String newToken;

  UserRefreshResponse(this.newToken);

  factory UserRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRefreshResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefreshResponseToJson(this);

  @override
  List<Object?> get props => [newToken];
}
