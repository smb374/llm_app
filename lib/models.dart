import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'models.g.dart';

// General
// ErrorResponse: for all errors from API return.
@JsonSerializable(checked: true)
class ErrorResponse {
  final String error;

  @JsonKey(defaultValue: false)
  final bool refresh;

  ErrorResponse(this.error, this.refresh);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

// User
// User
@JsonSerializable(checked: true)
class User {
  final String uuid;
  final String name;
  final String email;

  User(this.uuid, this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    final user = _$UserFromJson(json);

    if (!Uuid.isValidUUID(fromString: user.uuid)) {
      throw Exception("Failed to parse user: Invalid uuid");
    }

    return user;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// UserLoginResponse
@JsonSerializable(checked: true)
class UserLoginResponse {
  final String token;

  @JsonKey(name: "refreshtoken")
  final String refreshToken;

  UserLoginResponse(this.token, this.refreshToken);

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}

// UserRefreshResponse
@JsonSerializable(checked: true)
class UserRefreshResponse {
  @JsonKey(name: "new_token")
  final String newToken;

  UserRefreshResponse(this.newToken);

  factory UserRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRefreshResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefreshResponseToJson(this);
}

// Session
// MessageRole
enum MessageRole {
  @JsonValue("user")
  user,
  @JsonValue("assistant")
  assistant,
  @JsonValue("system")
  system,
}

// Message
@JsonSerializable(checked: true)
class Message {
  final MessageRole role;
  final String content;

  Message(this.role, this.content);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

// Session
@JsonSerializable(checked: true)
class Session {
  final String uuid;
  final String uid;
  String caption;

  @JsonKey(defaultValue: [])
  List<Message> messages;

  Session(this.uuid, this.uid, this.caption, this.messages);

  factory Session.fromJson(Map<String, dynamic> json) {
    final session = _$SessionFromJson(json);

    if (!Uuid.isValidUUID(fromString: session.uuid)) {
      throw Exception("Failed to parse session: Invalid uuid");
    }
    if (!Uuid.isValidUUID(fromString: session.uid)) {
      throw Exception("Failed to parse session: Invalid uid");
    }

    return session;
  }

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

// SessionListResponse
@JsonSerializable(checked: true)
class SessionListResponse {
  final List<Session> sessions;

  SessionListResponse(this.sessions);

  factory SessionListResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$SessionListResponseFromJson(json);
    } catch (e) {
      throw Exception("Failed to parse session list response: $e");
    }
  }

  Map<String, dynamic> toJson() => _$SessionListResponseToJson(this);
}

// SessionCreateResponse
@JsonSerializable(checked: true)
class SessionCreateResponse {
  final String id;

  SessionCreateResponse(this.id);

  factory SessionCreateResponse.fromJson(Map<String, dynamic> json) {
    final result = _$SessionCreateResponseFromJson(json);

    if (!Uuid.isValidUUID(fromString: result.id)) {
      throw Exception("Failed to parse session create response: Invalid id");
    }

    return result;
  }

  Map<String, dynamic> toJson() => _$SessionCreateResponseToJson(this);
}

// SessionGetResponse
@JsonSerializable(checked: true)
class SessionGetResponse {
  final Session session;

  SessionGetResponse(this.session);

  factory SessionGetResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$SessionGetResponseFromJson(json);
    } catch (e) {
      throw Exception("Failed to parse session get response: $e");
    }
  }

  Map<String, dynamic> toJson() => _$SessionGetResponseToJson(this);
}

// Chat
// ChatData
@JsonSerializable(checked: true)
class ChatData {
  final String model;

  @JsonKey(name: "created_at")
  final String createdAt;

  final Message message;

  @JsonKey(defaultValue: false)
  final bool done;

  ChatData(this.model, this.createdAt, this.message, this.done);

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}

// ChatProgress
@JsonSerializable(checked: true)
class ChatProgress {
  final ChatData data;
  final String? error;
  final bool end;

  ChatProgress(this.data, this.error, this.end);

  factory ChatProgress.fromJson(Map<String, dynamic> json) =>
      _$ChatProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ChatProgressToJson(this);
}

// ProgressResponse
@JsonSerializable(checked: true)
class ProgressResponse {
  @JsonKey(name: "status_id")
  final String statusId;

  ProgressResponse(this.statusId);

  factory ProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressResponseToJson(this);
}
