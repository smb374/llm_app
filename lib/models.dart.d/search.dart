part of '../models.dart';

// Search
enum CaseType {
  V, // 民事
  M, // 刑事
  A, // 行政
  I, // 智財
  P; // 公懲
}

enum JudgeLevel {
  level1('1'), // 一審
  level2('2'), // 二審
  level3('3'); // 三審

  final String name;

  const JudgeLevel(this.name);
}

enum JType {
  J, // 判決
  R, // 裁定
  P, // 支付命令
  C; // 刑事補償
}

// Request Params
class SearchParams {
  String? querySentence; // 全文檢索; TODO: distinguish with keyword
  String? keyword; // 全文檢索
  String? dateStart; // 日期;     date: <dateStart>~<dateEnd>
  String? dateEnd; // 日期
  List<String>? caseNum; // 年度字號
  Set<CaseType>? caseTypes; // 類別
  Set<String>? courts; // 法院
  Set<JudgeLevel>? levels; // 審級
  Set<JType>? jtypes; // 判决/裁定
  String? issue; // 案由
  String? main; // 主文

  SearchParams({
    this.querySentence,
    this.keyword,
    this.dateStart,
    this.dateEnd,
    this.caseNum,
    this.caseTypes,
    this.courts,
    this.levels,
    this.jtypes,
    this.issue,
    this.main,
  });

  Map<String, String> toMap() {
    return {
      'querySentence': querySentence ?? '',
      'keyword': keyword ?? '',
      'dateStart': dateStart ?? '',
      'dateEnd': dateEnd ?? '',
      'caseNum': (caseNum ?? []).join(','),
      'caseTypes': (caseTypes ?? {}).map((v) => v.name).join(','),
      'courts': (courts ?? {}).join(','),
      'levels': (levels ?? {}).map((v) => v.name).join(','),
      'jtypes': (jtypes ?? {}).map((v) => v.name).join(','),
      'issue': issue ?? '',
      'main': main ?? '',
    };
  }
}

// Jumbo response
class SearchResponse with EquatableMixin {
  final SearchReportResponse reportResponse;
  final SearchLevelResponse levelResponse;
  final SearchCaseResponse caseResponse;

  SearchResponse(this.reportResponse, this.levelResponse, this.caseResponse);

  @override
  List<Object?> get props => [reportResponse, levelResponse, caseResponse];
}

// SearchReportResponse
@JsonSerializable(checked: true)
class SearchReportResponse with EquatableMixin {
  final int total;
  final int page;
  final int records;
  final List<SearchReportRow> rows;
  final SearchReportUserData userdata;

  SearchReportResponse(
    this.total,
    this.page,
    this.records,
    this.rows,
    this.userdata,
  );

  factory SearchReportResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReportResponseToJson(this);

  @override
  List<Object?> get props => [total, page, records, rows, userdata];
}

@JsonSerializable(checked: true)
class SearchReportUserData with EquatableMixin {
  final List<SearchReportSerie> series;
  final List<String> categories;

  SearchReportUserData(this.series, this.categories);

  factory SearchReportUserData.fromJson(Map<String, dynamic> json) =>
      _$SearchReportUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReportUserDataToJson(this);

  @override
  List<Object?> get props => [series, categories];
}

@JsonSerializable(checked: true)
class SearchReportSerie with EquatableMixin {
  final String name;
  final int y;

  SearchReportSerie(this.name, this.y);

  factory SearchReportSerie.fromJson(Map<String, dynamic> json) =>
      _$SearchReportSerieFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReportSerieToJson(this);

  @override
  List<Object?> get props => [name, y];
}

@JsonSerializable(checked: true)
class SearchReportRow with EquatableMixin {
  final String judgeDate;
  final String court;
  final String title;
  final String content;
  final String caseType;
  final List<String> tags;
  final String type;
  final List<String>? litigant;
  final String issue;
  final String jtype;
  final String caseNum;
  final String identifier;

  SearchReportRow(
    this.judgeDate,
    this.court,
    this.title,
    this.content,
    this.caseType,
    this.tags,
    this.type,
    this.litigant,
    this.issue,
    this.jtype,
    this.caseNum,
    this.identifier,
  );

  factory SearchReportRow.fromJson(Map<String, dynamic> json) =>
      _$SearchReportRowFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReportRowToJson(this);

  @override
  List<Object?> get props => [
        judgeDate,
        court,
        title,
        content,
        caseType,
        tags,
        type,
        litigant,
        issue,
        jtype,
        caseNum,
        identifier,
      ];
}

// SearchLevelResponse
@JsonSerializable(checked: true)
class SearchLevelResponse with EquatableMixin {
  final bool success;
  final String lastError;
  final List<SearchLevelElem> response;

  SearchLevelResponse(this.success, this.lastError, this.response);

  factory SearchLevelResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchLevelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLevelResponseToJson(this);

  @override
  List<Object?> get props => [success, lastError, response];
}

@JsonSerializable(checked: true)
class SearchLevelElem with EquatableMixin {
  final String name;
  final int count;

  SearchLevelElem(this.name, this.count);

  factory SearchLevelElem.fromJson(Map<String, dynamic> json) =>
      _$SearchLevelElemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLevelElemToJson(this);

  @override
  List<Object?> get props => [name, count];
}

// SearchCaseResponse
@JsonSerializable(checked: true)
class SearchCaseResponse with EquatableMixin {
  final bool success;
  final String lastError;
  final SearchCaseResponseData response;

  SearchCaseResponse(this.success, this.lastError, this.response);

  factory SearchCaseResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCaseResponseToJson(this);

  @override
  List<Object?> get props => [success, lastError, response];
}

@JsonSerializable(checked: true)
class SearchCaseResponseData with EquatableMixin {
  final List<SearchCaseJType> jtypes;
  final List<SearchCaseCase> cases;
  final List<SearchCaseCourt> courts;

  SearchCaseResponseData(this.jtypes, this.cases, this.courts);

  factory SearchCaseResponseData.fromJson(Map<String, dynamic> json) =>
      _$SearchCaseResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCaseResponseDataToJson(this);

  @override
  List<Object?> get props => [jtypes, cases, courts];
}

@JsonSerializable(checked: true)
class SearchCaseJType with EquatableMixin {
  final String name;
  final int count;
  final String jtype;

  SearchCaseJType(this.name, this.count, this.jtype);

  factory SearchCaseJType.fromJson(Map<String, dynamic> json) =>
      _$SearchCaseJTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCaseJTypeToJson(this);

  @override
  List<Object?> get props => [name, count, jtype];
}

@JsonSerializable(checked: true)
class SearchCaseCase with EquatableMixin {
  final String name;
  final int count;

  SearchCaseCase(this.name, this.count);

  factory SearchCaseCase.fromJson(Map<String, dynamic> json) =>
      _$SearchCaseCaseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCaseCaseToJson(this);

  @override
  List<Object?> get props => [name, count];
}

@JsonSerializable(checked: true)
class SearchCaseCourt with EquatableMixin {
  final String? name;
  final int count;
  final String courtCode;
  final String? courtName;

  SearchCaseCourt(this.name, this.count, this.courtCode, this.courtName);

  factory SearchCaseCourt.fromJson(Map<String, dynamic> json) =>
      _$SearchCaseCourtFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCaseCourtToJson(this);

  @override
  List<Object?> get props => [name, count, courtCode, courtName];
}

// Report
// ReportResponse
@JsonSerializable(checked: true)
class ReportResponse {
  final bool success;
  final String lastError;
  final ReportResponseData response;

  ReportResponse(
    this.success,
    this.lastError,
    this.response,
  );

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}

@JsonSerializable(checked: true)
class ReportResponseData {
  final ReportBase reportBase;
  final ReportDetail report;
  final List<ReportStatute> statute;
  final List<String> tags;

  ReportResponseData(
    this.reportBase,
    this.report,
    this.statute,
    this.tags,
  );

  factory ReportResponseData.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseDataToJson(this);
}

@JsonSerializable(checked: true)
class ReportDetail {
  final String courtCode;
  final String caseType;
  final int judgeDate;
  final int jyear;
  final String codeNum;
  final String jno;
  final int level;
  final List<String> caseNum;
  final String type;
  final dynamic plaintiff;
  final dynamic plaintiffLawyer;
  final dynamic plaintiffAgent;
  final List<String> defendant;
  final dynamic defendantLawyer;
  final dynamic defendantAgent;
  final List<String> prosecutor;
  final String presideJudge;
  final List<String> puisne;
  final String judge;
  final String clerk;
  final List<String> appellant;
  final dynamic appellantLawyer;
  final dynamic appellantAgent;
  final dynamic appellee;
  final dynamic appelleeLawyer;
  final dynamic appelleeAgent;
  final dynamic petitioner;
  final dynamic petitionerLawyer;
  final dynamic petitionerAgent;
  final dynamic beJudgedPerson;
  final dynamic inmate;
  final dynamic privateProsecutor;
  final dynamic respondent;
  final dynamic interlocutoryPetitioner;
  final dynamic chosenCounsel;
  final dynamic assignCounsel;
  final dynamic publicDefender;
  final dynamic publicJudge;
  final dynamic lawyerCustomers;
  final String main;
  final int result;
  final dynamic win;
  final dynamic lose;
  final dynamic sentence;
  final int money;
  final int proportion;
  final int amount;
  final bool flag;
  final String jtype;
  final String previousCaseNum;
  final int previousJudgeDate;
  final String previousCourtCode;
  final List<String> statute;
  final List<String> tags;
  final int lastUpdate;
  final String identifier;

  ReportDetail(
    this.courtCode,
    this.caseType,
    this.judgeDate,
    this.jyear,
    this.codeNum,
    this.jno,
    this.level,
    this.caseNum,
    this.type,
    this.plaintiff,
    this.plaintiffLawyer,
    this.plaintiffAgent,
    this.defendant,
    this.defendantLawyer,
    this.defendantAgent,
    this.prosecutor,
    this.presideJudge,
    this.puisne,
    this.judge,
    this.clerk,
    this.appellant,
    this.appellantLawyer,
    this.appellantAgent,
    this.appellee,
    this.appelleeLawyer,
    this.appelleeAgent,
    this.petitioner,
    this.petitionerLawyer,
    this.petitionerAgent,
    this.beJudgedPerson,
    this.inmate,
    this.privateProsecutor,
    this.respondent,
    this.interlocutoryPetitioner,
    this.chosenCounsel,
    this.assignCounsel,
    this.publicDefender,
    this.publicJudge,
    this.lawyerCustomers,
    this.main,
    this.result,
    this.win,
    this.lose,
    this.sentence,
    this.money,
    this.proportion,
    this.amount,
    this.flag,
    this.jtype,
    this.previousCaseNum,
    this.previousJudgeDate,
    this.previousCourtCode,
    this.statute,
    this.tags,
    this.lastUpdate,
    this.identifier,
  );

  factory ReportDetail.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDetailToJson(this);
}

@JsonSerializable(checked: true)
class ReportBase {
  final int judgeDate;
  final String issue;
  final String content;
  final String courtCode;
  final String caseType;
  final String caseNum;
  final int jyear;
  final String codeNum;
  final String jno;
  final int reportStatus;
  final dynamic gist;
  final dynamic summary;
  final String jtype;
  final dynamic fulltext;
  final int lastUpdate;
  final String source;
  final String identifier;

  ReportBase(
    this.judgeDate,
    this.issue,
    this.content,
    this.courtCode,
    this.caseType,
    this.caseNum,
    this.jyear,
    this.codeNum,
    this.jno,
    this.reportStatus,
    this.gist,
    this.summary,
    this.jtype,
    this.fulltext,
    this.lastUpdate,
    this.source,
    this.identifier,
  );

  factory ReportBase.fromJson(Map<String, dynamic> json) =>
      _$ReportBaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportBaseToJson(this);
}

@JsonSerializable(checked: true)
class ReportStatute {
  final List<ReportItem> items;
  final String statute;

  ReportStatute(
    this.items,
    this.statute,
  );

  factory ReportStatute.fromJson(Map<String, dynamic> json) =>
      _$ReportStatuteFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStatuteToJson(this);
}

@JsonSerializable(checked: true)
class ReportItem {
  final String num;
  final String cnum;
  final int val;

  ReportItem(
    this.num,
    this.cnum,
    this.val,
  );

  factory ReportItem.fromJson(Map<String, dynamic> json) =>
      _$ReportItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReportItemToJson(this);
}
