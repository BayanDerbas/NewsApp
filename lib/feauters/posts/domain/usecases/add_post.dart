import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/repositories/post_repository.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(PostEntity post) async {
    print("Add Post UseCase.............................................\n");
    return await repository.addPost(post);
  }
}