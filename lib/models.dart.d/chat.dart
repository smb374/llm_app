part of '../models.dart';

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
  final String error;
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
