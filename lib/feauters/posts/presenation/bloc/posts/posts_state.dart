part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  final List<PostEntity> posts;

  PostsSuccess({required this.posts});
    @override
  List<Object> get props => [posts];
}

class PostsFailure extends PostsState {
  final String message;

  PostsFailure({required this.message});
    @override
  List<Object> get props => [message];
}