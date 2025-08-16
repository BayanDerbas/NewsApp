import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/core/store/SharedPreferencesHelper.dart';
import 'package:posts/feauters/posts/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> CashePosts(List<PostModel> postModel);
}

const CashedPosts = "Cashed_Posts";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  // SharedPreferencesHelper preferencesHelper;
  // PostLocalDataSourceImpl({required this.preferencesHelper});
  @override
  Future<Unit> CashePosts(List<PostModel> postModel) {
    List postModelToJson =
        postModel
            .map<Map<String, dynamic>>((postModel) => postModel.toJson())
            .toList();
    SharedPreferencesHelper.setString(
      CashedPosts,
      json.encode(postModelToJson),
    );
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    final jsonString = SharedPreferencesHelper.getString(CashedPosts);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel =
          decodeJsonData
              .map<PostModel>(
                (jsonPostModel) => PostModel.fromJson(jsonPostModel),
              )
              .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}