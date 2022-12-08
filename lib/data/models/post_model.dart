import 'package:tdd_post/domain/entities/post_entity.dart';

List<PostModel> parseListPostFromJson(List list) {
  return list.map((item) => PostModel.fromJson(item)).toList();
}

List<Map<String, dynamic>> toListJson(List<PostModel> list) {
  return list.map((item) => item.toJson()).toList();
}

class PostModel extends Post {
  PostModel({required super.title, required super.body, required super.id, required super.userId});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}