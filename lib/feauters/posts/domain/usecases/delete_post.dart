import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/domain/repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int postId) async {
    print("Delet Post ${postId} UseCase...................................\n");
    return await repository.deletePost(postId);
  }
}