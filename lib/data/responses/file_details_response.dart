part of "../data.dart";

class FileDetailsResponse {
  final FileDetail? result;

  FileDetailsResponse({
    this.result,
  });

  factory FileDetailsResponse.fromJson(String str) => FileDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileDetailsResponse.fromMap(Map<String, dynamic> json) => FileDetailsResponse(
    result: json["result"] == null ? null : FileDetail.fromMap(json["result"]),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": result?.toMap(),
  };
}

class FileDetail {
  final String? fileId;
  final String? fileCode;
  final String? organId;
  final String? sectionCode;
  final int? familyCount;
  final int? personFamilyCount;
  final String? personnelCode;
  final String? createDate;

  FileDetail({
    this.fileId,
    this.fileCode,
    this.organId,
    this.sectionCode,
    this.familyCount,
    this.personFamilyCount,
    this.personnelCode,
    this.createDate,
  });

  factory FileDetail.fromJson(String str) => FileDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileDetail.fromMap(Map<String, dynamic> json) => FileDetail(
    fileId: json["fileId"],
    fileCode: json["fileCode"],
    organId: json["organId"],
    sectionCode: json["sectionCode"],
    familyCount: json["familyCount"],
    personFamilyCount: json["personFamilyCount"],
    personnelCode: json["personnelCode"],
    createDate: json["createDate"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "fileCode": fileCode,
    "organId": organId,
    "sectionCode": sectionCode,
    "familyCount": familyCount,
    "personFamilyCount": personFamilyCount,
    "personnelCode": personnelCode,
    "createDate": createDate,
  };
}
