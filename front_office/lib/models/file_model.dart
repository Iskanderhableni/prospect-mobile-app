import 'dart:convert';

import 'pin_model.dart';

FileModel pinModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String pinModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  FileModel({
    required this.id,
    required this.userId,
    required this.file,
    required this.title,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  int? id;
  int? userId;
  String? file;
  String? title;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        userId: json["user_id"],
        file: json["file"],
        title: json["title"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "file": file,
        "title": title,
        "note": note,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
      };
}
