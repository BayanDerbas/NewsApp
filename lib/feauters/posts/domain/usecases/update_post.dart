import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await repository.updatePost(post);
  }
}