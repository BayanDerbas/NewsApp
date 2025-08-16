import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase({required this.repository});
  Future<Either<Failure, List<PostEntity>>> call() async {
    print("Get All Posts UseCase...........\n");
    return await repository.getAllPosts();
  }
}