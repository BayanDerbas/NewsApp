import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/utils/backup_service.dart';
import '../bloc/posts/posts_bloc.dart';
import 'add_post_page.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _backupFile async {
    final path = await _localPath;
    return File('$path/posts_backup.json');
  }

  Future<void> backupPosts(List<PostEntity> posts) async {
    final file = await _backupFile;
    final jsonPosts = posts.map((p) => {
      'id': p.id,
      'title': p.title,
      'body': p.body,
    }).toList();
    await file.writeAsString(jsonEncode(jsonPosts));
  }

  Future<List<PostEntity>> restorePosts() async {
    try {
      final file = await _backupFile;
      if (!await file.exists()) return [];

      final jsonString = await file.readAsString();
      final List decoded = jsonDecode(jsonString);
      return decoded.map((p) => PostEntity(
        id: p['id'],
        title: p['title'],
        body: p['body'],
      )).toList();
    } catch (e) {
      print("Restore Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
          actions: [
            IconButton(
              icon: const Icon(Icons.backup),
              onPressed: () async {
                final state = context.read<PostsBloc>().state;
                if (state is PostsSuccess) {
                  final posts = state.posts.map((e) => PostEntity(
                    id: e.id,
                    title: e.title,
                    body: e.body,
                  )).toList();

                  await BackupService.backupPosts(posts, context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No posts to backup")),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.restore),
              onPressed: () async {
                final restoredPosts = await BackupService.restorePosts(context);
                if (restoredPosts.isNotEmpty) {
                  context.read<PostsBloc>().add(RestorePostsEvent(posts: restoredPosts));
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddPostPage()),
                );
              },
            ),
          ],
        ),
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
                      icon: Icon(Icons.share, color: Colors.green),
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
      )
    );
  }
}
