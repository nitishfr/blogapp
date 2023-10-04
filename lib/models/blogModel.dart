import 'dart:convert';

class BlogModel {
  String id;
  String imageUrl;
  String title;

  BlogModel({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
      };
}
