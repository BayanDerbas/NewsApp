import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/core/networks/network_info.dart';
import 'package:posts/feauters/posts/data/datasources/post_local_data_source.dart';
import 'package:posts/feauters/posts/data/models/post_model.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/repositories/post_repository.dart';
import '../datasources/post_api_service.dart';

typedef Future<Unit> DeleteOrUpdateOrAdd();

class PostRepositoryImpl implements PostRepository {
  final PostApiService service;

  PostRepositoryImpl({required this.service});
  // final PostApiService remoteDataSource;
  // final PostLocalDataSource localDataSource;
  // final NetworkInfo networkInfo;
  //
  // PostRepositoryImpl({
  //   required this.remoteDataSource,
  //   required this.localDataSource,
  //   required this.networkInfo,
  // });

  // Future<Either<Failure, Unit>> getMessage(DeleteOrUpdateOrAdd action) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       await action();
  //       return Right(unit);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     return Left(OffLineFailure());
  //   }
  // }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try{
      final result = await service.getAllPosts();
      return Right(result);
    }
    on DioException catch(e){
      print("Error : ${e}");
      return Left(ServerFailure());
    }
    catch (e){
      print("Exception Error : ${e}");
      return Left(ServerFailure());
    }
    // if (await networkInfo.isConnected) {
    //   try {
    //     final remotePosts = await remoteDataSource.getAllPosts();
    //     localDataSource.CashePosts(remotePosts);
    //     return Right(remotePosts);
    //   } on DioException catch (e) {
    //     final status = e.response?.statusCode ?? 'No status';
    //     final data = e.response?.data ?? 'No data';
    //     print("Dio Error: $status $data");
    //     return Left(ServerFailure());
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try {
    //     final localPosts = await localDataSource.getAllPosts();
    //     return Right(localPosts);
    //   } on EmptyCacheException {
    //     return Left(EmptyCacheFailure());
    //   }
    // }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post
      ) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, Unit>> addPost(PostEntity post) async {
  //   final postModel = PostModel(
  //     id: post.id,
  //     title: post.title,
  //     body: post.body,
  //   );
  //   return await getMessage(() async {
  //     await remoteDataSource.addPost(postModel);
  //     return unit;
  //   });
  // }

  // @override
  // Future<Either<Failure, Unit>> deletePost(int postId) async {
  //   return await getMessage(() async {
  //     await remoteDataSource.deletePost(postId);
  //     return unit;
  //   });
  // }
  //
  // @override
  // Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
  //   final postModel = PostModel(
  //     id: post.id,
  //     title: post.title,
  //     body: post.body,
  //   );
  //   return await getMessage(() async {
  //     await remoteDataSource.updatePost(postModel.id, postModel);
  //     return unit;
  //   });
  // }
}
