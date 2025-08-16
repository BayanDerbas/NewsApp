import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:share_plus/share_plus.dart';
import '../bloc/posts/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body:
      BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostsBloc>().add(RefreshPostsEvent());
              },
              child: ListView.separated(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final PostEntity post = state.posts[index];
                  return ListTile(
                    //leading: CircleAvatar(child: Text(post.id.toString()),),
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    trailing: IconButton(
                        onPressed: (){
                          Share.share(
                              'Post #${post.id}\n\n'
                                  'Title: ${post.title}\n\n'
                                  'Body: ${post.body}\n\n'
                                  '🔗 Link: https://jsonplaceholder.typicode.com/posts/${post.id}'
                          );
                        },
                        icon: Icon(Icons.share,color: Colors.green,),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
              ),
            );
          } else if (state is PostsFailure) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No posts yet."));
        },
      ),
    );
  }
}
