part of "../data.dart";

class FileDetailsParams {
  final String? fileId;

  FileDetailsParams({
    this.fileId,
  });

  factory FileDetailsParams.fromJson(String str) => FileDetailsParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileDetailsParams.fromMap(Map<String, dynamic> json) => FileDetailsParams(
    fileId: json["fileId"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
  };
}
