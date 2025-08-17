import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/data/models/post_model.dart';
import 'package:posts/feauters/posts/data/models/post_objectbox.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/repositories/post_repository.dart';
import '../datasources/post_api_service.dart';

typedef Future<Unit> DeleteOrUpdateOrAdd();

class PostRepositoryImpl implements PostRepository {
  final PostApiService service;

  PostRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      final result = await service.getAllPosts();

      final objects = result
          .map((post) => PostObjectBox(title: post.title, body: post.body))
          .toList();

      return Right(result);
    } on DioException catch (e) {
      print("Error : $e");
      return Left(ServerFailure());
    } catch (e) {
      print("Exception Error : $e");
      return Left(ServerFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    try {
      final postModel = PostModel(id: post.id, title: post.title, body: post.body);

      await service.addPost(postModel);

      final postObject = PostObjectBox(title: post.title, body: post.body);
      return Right(unit);
    } on DioException catch (e) {
      print("Add Post Error: $e");
      return Left(ServerFailure());
    } catch (e) {
      print("Add Post Exception: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    try {
      final postModel =
      PostModel(id: post.id, title: post.title, body: post.body);
      await service.updatePost(post.id, postModel);
      return Right(unit);
    } on DioException catch (e) {
      print("Update Post Error: $e");
      return Left(ServerFailure());
    } catch (e) {
      print("Update Post Exception: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    try {
      await service.deletePost(id);
      return Right(unit);
    } on DioException catch (e) {
      print("Delete Post Error: $e");
      return Left(ServerFailure());
    } catch (e) {
      print("Delete Post Exception: $e");
      return Left(ServerFailure());
    }
  }
}
