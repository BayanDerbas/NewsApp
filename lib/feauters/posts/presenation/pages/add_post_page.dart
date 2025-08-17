import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/add_delete_update_post/add_delete_update_bloc.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _addPost() {
    final post = PostEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      body: _bodyController.text,
    );

    context.read<AddDeleteUpdateBloc>().add(AddPostEvent(post: post));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: "Body"),
            ),
            const SizedBox(height: 20),
            BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
              listener: (context, state) {
                if (state is AddDeleteUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Post added successfully!")),
                  );
                } else if (state is AddDeleteUpdateFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed: ${state.message}")),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddDeleteUpdateLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: _addPost,
                  child: const Text("Add Post"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
