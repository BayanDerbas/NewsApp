import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../feauters/posts/domain/entities/post_entity.dart';
import 'dart:convert';

class BackupService {

  static Future<void> backupPosts(
    List<PostEntity> posts,
    BuildContext context,
  ) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Storage permission denied")),
          );
          return;
        }
      }

      Directory dir =
          Platform.isAndroid
              ? Directory('/storage/emulated/0/Download')
              : await getApplicationDocumentsDirectory();

      if (!await dir.exists()) await dir.create(recursive: true);

      String filePath = '${dir.path}/posts_backup.json';
      File file = File(filePath);

      String jsonData = jsonEncode(
        posts
            .map((p) => {'id': p.id, 'title': p.title, 'body': p.body})
            .toList(),
      );

      await file.writeAsString(jsonData);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("تم النسخ JSON في: $filePath")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("فشل النسخ: $e")));
    }
  }

  static Future<List<PostEntity>> restorePosts(BuildContext context) async {
    try {
      Directory dir =
          Platform.isAndroid
              ? Directory('/storage/emulated/0/Download')
              : await getApplicationDocumentsDirectory();

      File file = File('${dir.path}/posts_backup.json');

      if (!await file.exists()) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("لا يوجد نسخة احتياطية")));
        return [];
      }

      String jsonData = await file.readAsString();
      List<dynamic> list = jsonDecode(jsonData);

      List<PostEntity> restoredPosts =
          list
              .map(
                (item) => PostEntity(
                  id: item['id'] ?? 0,
                  title: item['title'] ?? '',
                  body: item['body'] ?? '',
                ),
              )
              .toList();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("تم استعادة النسخة بنجاح")));

      return restoredPosts;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("فشل الاستعادة: $e")));
      return [];
    }
  }
}