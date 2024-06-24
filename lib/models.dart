import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

part 'models.g.dart';

// General
// ErrorResponse: for all errors from API return.
@JsonSerializable(checked: true)
class ErrorResponse with EquatableMixin {
  final String error;

  @JsonKey(defaultValue: false)
  final bool refresh;

  ErrorResponse(this.error, this.refresh);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  List<Object?> get props => [error, refresh];
}

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

// Session
// MessageRole
enum MessageRole {
  @JsonValue('user')
  user,
  @JsonValue('assistant')
  assistant,
  @JsonValue('system')
  system,
}

// Message
@JsonSerializable(checked: true)
class Message with EquatableMixin {
  final MessageRole role;
  final String content;

  Message(this.role, this.content);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props => [role, content];
}

// Session
@JsonSerializable(checked: true)
class Session with EquatableMixin {
  final String uuid;
  final String uid;
  String caption;

  @JsonKey(name: 'created_at')
  final int createdAt;

  @JsonKey(defaultValue: [])
  List<Message> messages;

  Session(this.uuid, this.uid, this.caption, this.createdAt, this.messages);

  factory Session.fromJson(Map<String, dynamic> json) {
    final session = _$SessionFromJson(json);

    if (!Uuid.isValidUUID(fromString: session.uuid)) {
      throw Exception('Failed to parse session: Invalid uuid');
    }
    if (!Uuid.isValidUUID(fromString: session.uid)) {
      throw Exception('Failed to parse session: Invalid uid');
    }

    return session;
  }

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props => [uuid, uid, caption, messages];
}

// SessionListResponse
@JsonSerializable(checked: true)
class SessionListResponse with EquatableMixin {
  final List<Session> sessions;

  SessionListResponse(this.sessions);

  factory SessionListResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$SessionListResponseFromJson(json);
    } catch (e) {
      throw Exception('Failed to parse session list response: $e');
    }
  }

  Map<String, dynamic> toJson() => _$SessionListResponseToJson(this);

  @override
  List<Object?> get props => [sessions];
}

// SessionCreateResponse
@JsonSerializable(checked: true)
class SessionCreateResponse with EquatableMixin {
  @JsonKey(name: 'created')
  final Session session;

  SessionCreateResponse(this.session);

  factory SessionCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionCreateResponseToJson(this);

  @override
  List<Object?> get props => [session];
}

// SessionDeleteResponse
@JsonSerializable(checked: true)
class SessionDeleteResponse with EquatableMixin {
  @JsonKey(name: 'deleted_id')
  final String deletedId;

  SessionDeleteResponse(this.deletedId);

  factory SessionDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDeleteResponseToJson(this);

  @override
  List<Object?> get props => [deletedId];
}

// SessionGetResponse
@JsonSerializable(checked: true)
class SessionGetResponse with EquatableMixin {
  final Session session;

  SessionGetResponse(this.session);

  factory SessionGetResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$SessionGetResponseFromJson(json);
    } catch (e) {
      throw Exception('Failed to parse session get response: $e');
    }
  }

  Map<String, dynamic> toJson() => _$SessionGetResponseToJson(this);

  @override
  List<Object?> get props => [session];
}

// Chat
// ChatData
@JsonSerializable(checked: true)
class ChatData with EquatableMixin {
  final String model;

  @JsonKey(name: 'created_at')
  final String createdAt;

  final Message message;

  @JsonKey(defaultValue: false)
  final bool done;

  ChatData(this.model, this.createdAt, this.message, this.done);

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);

  @override
  List<Object?> get props => [model, createdAt, message, done];
}

// ChatProgress
@JsonSerializable(checked: true)
class ChatProgress with EquatableMixin {
  final ChatData? data;
  final String? error;
  final bool end;

  ChatProgress(this.data, this.error, this.end);

  factory ChatProgress.fromJson(Map<String, dynamic> json) =>
      _$ChatProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ChatProgressToJson(this);

  @override
  List<Object?> get props => [data, error, end];
}

// ProgressResponse
@JsonSerializable(checked: true)
class ProgressResponse with EquatableMixin {
  @JsonKey(name: 'status_id')
  final String statusId;

  ProgressResponse(this.statusId);

  factory ProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressResponseToJson(this);

  @override
  List<Object?> get props => [statusId];
}
