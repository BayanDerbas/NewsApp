import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/core/networks/api_constant.dart';
import 'package:posts/feauters/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> deletePost(int postId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<Unit> addPost(PostModel post) async {
    try{
      final response = await dio.post(
        ApiConstant.posts,
        data :{
          "title" : post.title,
          "body" : post.body,
        },
        options: Options(
          headers: {'Content-Type' : 'application/json'},
        ),
      );
      if(response.statusCode == 200){
        return unit;
      }
      else{
        throw ServerException();
      }
    } on DioException catch(e){
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    try {
      final response = await dio.delete(
        ApiConstant.posts + "/${postId.toString()}",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if(response.statusCode == 201 || response.statusCode == 200 ){
        return unit;
      }
      else {
        throw ServerException();
      }
    }
    on DioException catch(e){
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts () async {
    try{
     final response =  await dio.get(
       ApiConstant.posts,
       options: Options(
         headers: {'Content-Type' : 'application/json'},
       ),
     );
     if (response.statusCode == 200 || response.statusCode == 201){
       final List<dynamic> decodeJson = response.data;
       final List<PostModel>posts = decodeJson.map<PostModel>((json) => PostModel.fromJson(json)).toList();
       return posts;
     }
     else {
       throw ServerException();
     }
    }
    on DioException catch(e){
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    try{
      final response = await dio.patch(
        ApiConstant.posts + "/${post.id}",
        options: Options(
          headers: {
            'Content-Type' : 'application/json'
          },
        ),
        data: {
          "title" : post.title,
          "body" : post.body,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201){
        return unit;
      }
      else{
        throw ServerException();
      }
    }
    on DioException catch(e){
      throw ServerException();
    }
  }
}
