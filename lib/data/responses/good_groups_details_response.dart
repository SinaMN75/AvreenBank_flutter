part of "../data.dart";

extension GramExtension on int? {
  String gram() => "${(this ?? 0).separate3By3()} ${U.s.gram}";
}

extension GoodGroupExtension on GoodGroup {
  int remainingPercent() => (limitWeight ?? 0) <= 0 ? 0 : ((remWeight ?? 0) * 100 / limitWeight!).round().clamp(0, 100);
}

class GoodGroupsDetailsResponse {
  GoodGroupsDetailsResponse({
    this.result = const <GoodGroup>[],
  });

  factory GoodGroupsDetailsResponse.fromJson(String str) => GoodGroupsDetailsResponse.fromMap(json.decode(str));

  factory GoodGroupsDetailsResponse.fromMap(Map<String, dynamic> json) => GoodGroupsDetailsResponse(
    result: json["result"] == null ? <GoodGroup>[] : List<GoodGroup>.from(json["result"].map(GoodGroup.fromMap)),
  );

  final List<GoodGroup> result;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": List<dynamic>.from(result.map((GoodGroup x) => x.toMap())),
  };
}

class GoodGroup {
  GoodGroup({
    this.groupId,
    this.groupName,
    this.regDate,
    this.remWeight,
    this.limitWeight,
  });

  factory GoodGroup.fromJson(String str) => GoodGroup.fromMap(json.decode(str));

  factory GoodGroup.fromMap(dynamic json) => GoodGroup(
    groupId: json["groupId"],
    groupName: json["groupName"],
    regDate: json["regDate"],
    remWeight: (json["remWeight"] as num?)?.toInt(),
    limitWeight: (json["limitWeight"] as num?)?.toInt(),
  );

  final String? groupId;
  final String? groupName;
  final String? regDate;
  final int? remWeight;
  final int? limitWeight;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "groupId": groupId,
    "groupName": groupName,
    "regDate": regDate,
    "remWeight": remWeight,
    "limitWeight": limitWeight,
  };
}
