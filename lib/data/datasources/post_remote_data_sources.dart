import 'dart:convert';
import '../../core/error/exception.dart';
import '../../domain/entities/post_entity.dart';
import '../models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPost();
  Future<Post> createPost(Map<String, dynamic> json);
  Future<Post> editPost(Map<String, dynamic> json, String id);
  Future<bool> deletePost(String id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(
      Uri.parse("https://630ddfe9109c16b9abef55a6.mockapi.io/api/v1/posts"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return parseListPostFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Post> createPost(Map<String, dynamic> json) async{
    final response = await client.post(
        Uri.parse("https://630ddfe9109c16b9abef55a6.mockapi.io/api/v1/posts"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(json)
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deletePost(String id) async {
    final response = await client.delete(
      Uri.parse("https://630ddfe9109c16b9abef55a6.mockapi.io/api/v1/posts/$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Post> editPost(Map<String, dynamic> json, String id) async {
    final response = await client.put(
        Uri.parse("https://630ddfe9109c16b9abef55a6.mockapi.io/api/v1/posts/$id"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(json)
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}