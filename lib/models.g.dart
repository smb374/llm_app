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
          $checkedConvert('uuid', (v) => v as String?),
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
          $checkedConvert('created_at', (v) => (v as num).toInt()),
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
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'uid': instance.uid,
      'caption': instance.caption,
      'created_at': instance.createdAt,
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
          $checkedConvert(
              'created', (v) => Session.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'session': 'created'},
    );

Map<String, dynamic> _$SessionCreateResponseToJson(
        SessionCreateResponse instance) =>
    <String, dynamic>{
      'created': instance.session,
    };

SessionDeleteResponse _$SessionDeleteResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SessionDeleteResponse',
      json,
      ($checkedConvert) {
        final val = SessionDeleteResponse(
          $checkedConvert('deleted_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'deletedId': 'deleted_id'},
    );

Map<String, dynamic> _$SessionDeleteResponseToJson(
        SessionDeleteResponse instance) =>
    <String, dynamic>{
      'deleted_id': instance.deletedId,
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
              'data',
              (v) => v == null
                  ? null
                  : ChatData.fromJson(v as Map<String, dynamic>)),
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

SearchReportResponse _$SearchReportResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchReportResponse',
      json,
      ($checkedConvert) {
        final val = SearchReportResponse(
          $checkedConvert('total', (v) => (v as num).toInt()),
          $checkedConvert('page', (v) => (v as num).toInt()),
          $checkedConvert('records', (v) => (v as num).toInt()),
          $checkedConvert(
              'rows',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SearchReportRow.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('userdata',
              (v) => SearchReportUserData.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchReportResponseToJson(
        SearchReportResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'records': instance.records,
      'rows': instance.rows,
      'userdata': instance.userdata,
    };

SearchReportUserData _$SearchReportUserDataFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchReportUserData',
      json,
      ($checkedConvert) {
        final val = SearchReportUserData(
          $checkedConvert(
              'series',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SearchReportSerie.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('categories',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchReportUserDataToJson(
        SearchReportUserData instance) =>
    <String, dynamic>{
      'series': instance.series,
      'categories': instance.categories,
    };

SearchReportSerie _$SearchReportSerieFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchReportSerie',
      json,
      ($checkedConvert) {
        final val = SearchReportSerie(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('y', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchReportSerieToJson(SearchReportSerie instance) =>
    <String, dynamic>{
      'name': instance.name,
      'y': instance.y,
    };

SearchReportRow _$SearchReportRowFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchReportRow',
      json,
      ($checkedConvert) {
        final val = SearchReportRow(
          $checkedConvert('judgeDate', (v) => v as String),
          $checkedConvert('court', (v) => v as String),
          $checkedConvert('title', (v) => v as String),
          $checkedConvert('content', (v) => v as String),
          $checkedConvert('caseType', (v) => v as String),
          $checkedConvert('tags',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          $checkedConvert('type', (v) => v as String?),
          $checkedConvert('litigant',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          $checkedConvert('issue', (v) => v as String),
          $checkedConvert('jtype', (v) => v as String?),
          $checkedConvert('caseNum', (v) => v as String),
          $checkedConvert('identifier', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchReportRowToJson(SearchReportRow instance) =>
    <String, dynamic>{
      'judgeDate': instance.judgeDate,
      'court': instance.court,
      'title': instance.title,
      'content': instance.content,
      'caseType': instance.caseType,
      'tags': instance.tags,
      'type': instance.type,
      'litigant': instance.litigant,
      'issue': instance.issue,
      'jtype': instance.jtype,
      'caseNum': instance.caseNum,
      'identifier': instance.identifier,
    };

SearchLevelResponse _$SearchLevelResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchLevelResponse',
      json,
      ($checkedConvert) {
        final val = SearchLevelResponse(
          $checkedConvert('success', (v) => v as bool),
          $checkedConvert('lastError', (v) => v as String),
          $checkedConvert(
              'response',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SearchLevelElem.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchLevelResponseToJson(
        SearchLevelResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'lastError': instance.lastError,
      'response': instance.response,
    };

SearchLevelElem _$SearchLevelElemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchLevelElem',
      json,
      ($checkedConvert) {
        final val = SearchLevelElem(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('count', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchLevelElemToJson(SearchLevelElem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };

SearchCaseResponse _$SearchCaseResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCaseResponse',
      json,
      ($checkedConvert) {
        final val = SearchCaseResponse(
          $checkedConvert('success', (v) => v as bool),
          $checkedConvert('lastError', (v) => v as String),
          $checkedConvert(
              'response',
              (v) =>
                  SearchCaseResponseData.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchCaseResponseToJson(SearchCaseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'lastError': instance.lastError,
      'response': instance.response,
    };

SearchCaseResponseData _$SearchCaseResponseDataFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCaseResponseData',
      json,
      ($checkedConvert) {
        final val = SearchCaseResponseData(
          $checkedConvert(
              'jtypes',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SearchCaseJType.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert(
              'cases',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => SearchCaseCase.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert(
              'courts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SearchCaseCourt.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchCaseResponseDataToJson(
        SearchCaseResponseData instance) =>
    <String, dynamic>{
      'jtypes': instance.jtypes,
      'cases': instance.cases,
      'courts': instance.courts,
    };

SearchCaseJType _$SearchCaseJTypeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCaseJType',
      json,
      ($checkedConvert) {
        final val = SearchCaseJType(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('count', (v) => (v as num).toInt()),
          $checkedConvert('jtype', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchCaseJTypeToJson(SearchCaseJType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'jtype': instance.jtype,
    };

SearchCaseCase _$SearchCaseCaseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCaseCase',
      json,
      ($checkedConvert) {
        final val = SearchCaseCase(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('count', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchCaseCaseToJson(SearchCaseCase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };

SearchCaseCourt _$SearchCaseCourtFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCaseCourt',
      json,
      ($checkedConvert) {
        final val = SearchCaseCourt(
          $checkedConvert('name', (v) => v as String?),
          $checkedConvert('count', (v) => (v as num).toInt()),
          $checkedConvert('courtCode', (v) => v as String),
          $checkedConvert('courtName', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchCaseCourtToJson(SearchCaseCourt instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'courtCode': instance.courtCode,
      'courtName': instance.courtName,
    };

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReportResponse',
      json,
      ($checkedConvert) {
        final val = ReportResponse(
          $checkedConvert('success', (v) => v as bool),
          $checkedConvert('lastError', (v) => v as String),
          $checkedConvert('response',
              (v) => ReportResponseData.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'lastError': instance.lastError,
      'response': instance.response,
    };

ReportResponseData _$ReportResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReportResponseData',
      json,
      ($checkedConvert) {
        final val = ReportResponseData(
          $checkedConvert('reportBase',
              (v) => ReportBase.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('report',
              (v) => ReportDetail.fromJson(v as Map<String, dynamic>)),
          $checkedConvert(
              'statute',
              (v) => (v as List<dynamic>)
                  .map((e) => ReportStatute.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tags',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReportResponseDataToJson(ReportResponseData instance) =>
    <String, dynamic>{
      'reportBase': instance.reportBase,
      'report': instance.report,
      'statute': instance.statute,
      'tags': instance.tags,
    };

ReportDetail _$ReportDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReportDetail',
      json,
      ($checkedConvert) {
        final val = ReportDetail(
          $checkedConvert('courtCode', (v) => v as String),
          $checkedConvert('caseType', (v) => v as String),
          $checkedConvert('judgeDate', (v) => (v as num).toInt()),
          $checkedConvert('jyear', (v) => (v as num).toInt()),
          $checkedConvert('codeNum', (v) => v as String),
          $checkedConvert('jno', (v) => v as String),
          $checkedConvert('level', (v) => (v as num).toInt()),
          $checkedConvert('caseNum',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('type', (v) => v as String),
          $checkedConvert('plaintiff', (v) => v),
          $checkedConvert('plaintiffLawyer', (v) => v),
          $checkedConvert('plaintiffAgent', (v) => v),
          $checkedConvert('defendant',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('defendantLawyer', (v) => v),
          $checkedConvert('defendantAgent', (v) => v),
          $checkedConvert('prosecutor',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('presideJudge', (v) => v as String),
          $checkedConvert('puisne',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('judge', (v) => v as String),
          $checkedConvert('clerk', (v) => v as String),
          $checkedConvert('appellant',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('appellantLawyer', (v) => v),
          $checkedConvert('appellantAgent', (v) => v),
          $checkedConvert('appellee', (v) => v),
          $checkedConvert('appelleeLawyer', (v) => v),
          $checkedConvert('appelleeAgent', (v) => v),
          $checkedConvert('petitioner', (v) => v),
          $checkedConvert('petitionerLawyer', (v) => v),
          $checkedConvert('petitionerAgent', (v) => v),
          $checkedConvert('beJudgedPerson', (v) => v),
          $checkedConvert('inmate', (v) => v),
          $checkedConvert('privateProsecutor', (v) => v),
          $checkedConvert('respondent', (v) => v),
          $checkedConvert('interlocutoryPetitioner', (v) => v),
          $checkedConvert('chosenCounsel', (v) => v),
          $checkedConvert('assignCounsel', (v) => v),
          $checkedConvert('publicDefender', (v) => v),
          $checkedConvert('publicJudge', (v) => v),
          $checkedConvert('lawyerCustomers', (v) => v),
          $checkedConvert('main', (v) => v as String),
          $checkedConvert('result', (v) => (v as num).toInt()),
          $checkedConvert('win', (v) => v),
          $checkedConvert('lose', (v) => v),
          $checkedConvert('sentence', (v) => v),
          $checkedConvert('money', (v) => (v as num).toInt()),
          $checkedConvert('proportion', (v) => (v as num).toInt()),
          $checkedConvert('amount', (v) => (v as num).toInt()),
          $checkedConvert('flag', (v) => v as bool),
          $checkedConvert('jtype', (v) => v as String),
          $checkedConvert('previousCaseNum', (v) => v as String),
          $checkedConvert('previousJudgeDate', (v) => (v as num).toInt()),
          $checkedConvert('previousCourtCode', (v) => v as String),
          $checkedConvert('statute',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('tags',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('lastUpdate', (v) => (v as num).toInt()),
          $checkedConvert('identifier', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReportDetailToJson(ReportDetail instance) =>
    <String, dynamic>{
      'courtCode': instance.courtCode,
      'caseType': instance.caseType,
      'judgeDate': instance.judgeDate,
      'jyear': instance.jyear,
      'codeNum': instance.codeNum,
      'jno': instance.jno,
      'level': instance.level,
      'caseNum': instance.caseNum,
      'type': instance.type,
      'plaintiff': instance.plaintiff,
      'plaintiffLawyer': instance.plaintiffLawyer,
      'plaintiffAgent': instance.plaintiffAgent,
      'defendant': instance.defendant,
      'defendantLawyer': instance.defendantLawyer,
      'defendantAgent': instance.defendantAgent,
      'prosecutor': instance.prosecutor,
      'presideJudge': instance.presideJudge,
      'puisne': instance.puisne,
      'judge': instance.judge,
      'clerk': instance.clerk,
      'appellant': instance.appellant,
      'appellantLawyer': instance.appellantLawyer,
      'appellantAgent': instance.appellantAgent,
      'appellee': instance.appellee,
      'appelleeLawyer': instance.appelleeLawyer,
      'appelleeAgent': instance.appelleeAgent,
      'petitioner': instance.petitioner,
      'petitionerLawyer': instance.petitionerLawyer,
      'petitionerAgent': instance.petitionerAgent,
      'beJudgedPerson': instance.beJudgedPerson,
      'inmate': instance.inmate,
      'privateProsecutor': instance.privateProsecutor,
      'respondent': instance.respondent,
      'interlocutoryPetitioner': instance.interlocutoryPetitioner,
      'chosenCounsel': instance.chosenCounsel,
      'assignCounsel': instance.assignCounsel,
      'publicDefender': instance.publicDefender,
      'publicJudge': instance.publicJudge,
      'lawyerCustomers': instance.lawyerCustomers,
      'main': instance.main,
      'result': instance.result,
      'win': instance.win,
      'lose': instance.lose,
      'sentence': instance.sentence,
      'money': instance.money,
      'proportion': instance.proportion,
      'amount': instance.amount,
      'flag': instance.flag,
      'jtype': instance.jtype,
      'previousCaseNum': instance.previousCaseNum,
      'previousJudgeDate': instance.previousJudgeDate,
      'previousCourtCode': instance.previousCourtCode,
      'statute': instance.statute,
      'tags': instance.tags,
      'lastUpdate': instance.lastUpdate,
      'identifier': instance.identifier,
    };

ReportBase _$ReportBaseFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ReportBase',
      json,
      ($checkedConvert) {
        final val = ReportBase(
          $checkedConvert('judgeDate', (v) => (v as num).toInt()),
          $checkedConvert('issue', (v) => v as String),
          $checkedConvert('content', (v) => v as String),
          $checkedConvert('courtCode', (v) => v as String),
          $checkedConvert('caseType', (v) => v as String),
          $checkedConvert('caseNum', (v) => v as String),
          $checkedConvert('jyear', (v) => (v as num).toInt()),
          $checkedConvert('codeNum', (v) => v as String),
          $checkedConvert('jno', (v) => v as String),
          $checkedConvert('reportStatus', (v) => (v as num).toInt()),
          $checkedConvert('gist', (v) => v),
          $checkedConvert('summary', (v) => v),
          $checkedConvert('jtype', (v) => v as String),
          $checkedConvert('fulltext', (v) => v),
          $checkedConvert('lastUpdate', (v) => (v as num).toInt()),
          $checkedConvert('source', (v) => v as String),
          $checkedConvert('identifier', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReportBaseToJson(ReportBase instance) =>
    <String, dynamic>{
      'judgeDate': instance.judgeDate,
      'issue': instance.issue,
      'content': instance.content,
      'courtCode': instance.courtCode,
      'caseType': instance.caseType,
      'caseNum': instance.caseNum,
      'jyear': instance.jyear,
      'codeNum': instance.codeNum,
      'jno': instance.jno,
      'reportStatus': instance.reportStatus,
      'gist': instance.gist,
      'summary': instance.summary,
      'jtype': instance.jtype,
      'fulltext': instance.fulltext,
      'lastUpdate': instance.lastUpdate,
      'source': instance.source,
      'identifier': instance.identifier,
    };

ReportStatute _$ReportStatuteFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReportStatute',
      json,
      ($checkedConvert) {
        final val = ReportStatute(
          $checkedConvert(
              'items',
              (v) => (v as List<dynamic>)
                  .map((e) => ReportItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('statute', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReportStatuteToJson(ReportStatute instance) =>
    <String, dynamic>{
      'items': instance.items,
      'statute': instance.statute,
    };

ReportItem _$ReportItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ReportItem',
      json,
      ($checkedConvert) {
        final val = ReportItem(
          $checkedConvert('num', (v) => v as String),
          $checkedConvert('cnum', (v) => v as String),
          $checkedConvert('val', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReportItemToJson(ReportItem instance) =>
    <String, dynamic>{
      'num': instance.num,
      'cnum': instance.cnum,
      'val': instance.val,
    };
