import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/error/exception.dart';
import '../models/post_model.dart';

const CACHED_LIST_POST = 'CACHED_LIST_POST';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getLastListPost();

  Future<void>  cacheNListPost(List<PostModel> postListToCache);

  Future<void>  cacheOneAddPost(PostModel post);

  Future<void>  cacheOneUpdatePost(PostModel post);

  Future<void>  cacheOneDeletePost(String id);

  Future<PostModel>  getOnePost(String id);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PostModel>> getLastListPost() {
    final jsonString = sharedPreferences.getString(CACHED_LIST_POST);
    if (jsonString != null) {
      return Future.value(parseListPostFromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNListPost(List<PostModel> postListToCache) {
    return sharedPreferences.setString(
      CACHED_LIST_POST,
      json.encode(toListJson(postListToCache)),
    );
  }

  @override
  Future<void> cacheOneAddPost(PostModel post) async {
    final jsonString = sharedPreferences.getString(CACHED_LIST_POST);
    if (jsonString != null) {
      List<PostModel> list = await Future.value(parseListPostFromJson(json.decode(jsonString)));
      list.add(post);
      await sharedPreferences.setString(
        CACHED_LIST_POST,
        json.encode(toListJson(list)),
      );
    } else {
      await sharedPreferences.setString(
        CACHED_LIST_POST,
        json.encode(toListJson([post])),
      );
    }
  }

  @override
  Future<void> cacheOneUpdatePost(PostModel post) async {
    final jsonString = sharedPreferences.getString(CACHED_LIST_POST);
    if (jsonString != null) {
      List<PostModel> list = await Future.value(parseListPostFromJson(json.decode(jsonString)));
      list.removeWhere((element) => element.id == post.id);
      list.add(post);
      await sharedPreferences.setString(
        CACHED_LIST_POST,
        json.encode(toListJson(list)),
      );
    } else {
      await sharedPreferences.setString(
        CACHED_LIST_POST,
        json.encode(toListJson([post])),
      );
    }
  }

  @override
  Future<void> cacheOneDeletePost(String id) async {
    final jsonString = sharedPreferences.getString(CACHED_LIST_POST);
    if (jsonString != null) {
      List<PostModel> list = await Future.value(parseListPostFromJson(json.decode(jsonString)));
      list.removeWhere((element) => element.id == id);
      await sharedPreferences.setString(
        CACHED_LIST_POST,
        json.encode(toListJson(list)),
      );
    }
  }

  @override
  Future<PostModel> getOnePost(String id) async {
    final jsonString = sharedPreferences.getString(CACHED_LIST_POST);
    List<PostModel> list = await Future.value(parseListPostFromJson(json.decode(jsonString!)));
    return list.firstWhere((element) => element.id == id);
  }
}
