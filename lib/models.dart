import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

// parts
part 'models.dart.d/user.dart';
part 'models.dart.d/session.dart';
part 'models.dart.d/chat.dart';
part 'models.dart.d/search.dart';
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
