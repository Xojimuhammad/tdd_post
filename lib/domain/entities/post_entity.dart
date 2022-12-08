import 'package:equatable/equatable.dart';

class Post extends Equatable {
  String title;
  String body;
  String id;
  int userId;

  Post({
    required this.title,
    required this.body,
    required this.id,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, body, title, userId];
}