part of "../data.dart";

class GoodGroupsDetailsParams {
  GoodGroupsDetailsParams({
    required this.fileId,
  });

  factory GoodGroupsDetailsParams.fromJson(String str) => GoodGroupsDetailsParams.fromMap(json.decode(str));

  factory GoodGroupsDetailsParams.fromMap(Map<String, dynamic> json) => GoodGroupsDetailsParams(
    fileId: json["fileId"],
  );

  final String fileId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
  };
}
