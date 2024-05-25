// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ErrorResponse',
      json,
      ($checkedConvert) {
        final val = ErrorResponse(
          $checkedConvert('error', (v) => v as String),
          $checkedConvert('refresh', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'refresh': instance.refresh,
    };

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'User',
      json,
      ($checkedConvert) {
        final val = User(
          $checkedConvert('uuid', (v) => v as String),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('email', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'email': instance.email,
    };

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserLoginResponse',
      json,
      ($checkedConvert) {
        final val = UserLoginResponse(
          $checkedConvert('token', (v) => v as String),
          $checkedConvert('refreshtoken', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'refreshToken': 'refreshtoken'},
    );

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshtoken': instance.refreshToken,
    };

UserRefreshResponse _$UserRefreshResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserRefreshResponse',
      json,
      ($checkedConvert) {
        final val = UserRefreshResponse(
          $checkedConvert('new_token', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'newToken': 'new_token'},
    );

Map<String, dynamic> _$UserRefreshResponseToJson(
        UserRefreshResponse instance) =>
    <String, dynamic>{
      'new_token': instance.newToken,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Message',
      json,
      ($checkedConvert) {
        final val = Message(
          $checkedConvert('role', (v) => $enumDecode(_$MessageRoleEnumMap, v)),
          $checkedConvert('content', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'role': _$MessageRoleEnumMap[instance.role]!,
      'content': instance.content,
    };

const _$MessageRoleEnumMap = {
  MessageRole.user: 'user',
  MessageRole.assistant: 'assistant',
  MessageRole.system: 'system',
};

Session _$SessionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Session',
      json,
      ($checkedConvert) {
        final val = Session(
          $checkedConvert('uuid', (v) => v as String),
          $checkedConvert('uid', (v) => v as String),
          $checkedConvert('caption', (v) => v as String),
          $checkedConvert(
              'messages',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  []),
        );
        return val;
      },
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'uid': instance.uid,
      'caption': instance.caption,
      'messages': instance.messages,
    };

SessionListResponse _$SessionListResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SessionListResponse',
      json,
      ($checkedConvert) {
        final val = SessionListResponse(
          $checkedConvert(
              'sessions',
              (v) => (v as List<dynamic>)
                  .map((e) => Session.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SessionListResponseToJson(
        SessionListResponse instance) =>
    <String, dynamic>{
      'sessions': instance.sessions,
    };

SessionCreateResponse _$SessionCreateResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SessionCreateResponse',
      json,
      ($checkedConvert) {
        final val = SessionCreateResponse(
          $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$SessionCreateResponseToJson(
        SessionCreateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SessionGetResponse _$SessionGetResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SessionGetResponse',
      json,
      ($checkedConvert) {
        final val = SessionGetResponse(
          $checkedConvert(
              'session', (v) => Session.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$SessionGetResponseToJson(SessionGetResponse instance) =>
    <String, dynamic>{
      'session': instance.session,
    };

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatData',
      json,
      ($checkedConvert) {
        final val = ChatData(
          $checkedConvert('model', (v) => v as String),
          $checkedConvert('created_at', (v) => v as String),
          $checkedConvert(
              'message', (v) => Message.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('done', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'model': instance.model,
      'created_at': instance.createdAt,
      'message': instance.message,
      'done': instance.done,
    };

ChatProgress _$ChatProgressFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChatProgress',
      json,
      ($checkedConvert) {
        final val = ChatProgress(
          $checkedConvert(
              'data', (v) => ChatData.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('error', (v) => v as String?),
          $checkedConvert('end', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChatProgressToJson(ChatProgress instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'end': instance.end,
    };

ProgressResponse _$ProgressResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProgressResponse',
      json,
      ($checkedConvert) {
        final val = ProgressResponse(
          $checkedConvert('status_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'statusId': 'status_id'},
    );

Map<String, dynamic> _$ProgressResponseToJson(ProgressResponse instance) =>
    <String, dynamic>{
      'status_id': instance.statusId,
    };
