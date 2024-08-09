part of '../models.dart';

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
