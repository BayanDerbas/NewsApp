part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent {}

class RefreshPostsEvent extends PostsEvent {}

class LoadRestoredPostsEvent extends PostsEvent {
  final List<PostEntity> posts;
  LoadRestoredPostsEvent(this.posts);
}

class RestorePostsEvent extends PostsEvent {
  final List<PostEntity> posts;

  RestorePostsEvent({required this.posts});
}
