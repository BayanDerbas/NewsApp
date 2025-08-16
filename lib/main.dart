import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/feauters/posts/data/datasources/post_api_service.dart';
import 'package:posts/feauters/posts/data/repositories/post_repository_impl.dart';
import 'package:posts/feauters/posts/domain/usecases/get_all_posts.dart';
import 'package:posts/feauters/posts/presenation/bloc/posts/posts_bloc.dart';
import 'package:posts/feauters/posts/presenation/pages/posts_page.dart';
import 'core/constants/app_theme.dart';
import 'core/notifications/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  NotificationService().showInstantNotification(
    title: "👋 Welcome",
    body: "The app just started!",
  );
  NotificationService().scheduleEveryXMinutesNotification(
    id: 4,
    title: "⚡ Quick Reminder",
    body: "This shows every 1 minutes!",
    intervalMinutes: 1,
  );
  NotificationService().scheduleEveryXHoursNotification(
    id: 3,
    title: "⏰ Reminder",
    body: "This shows every 2 hours!",
    intervalHours: 2,
  );
  NotificationService().scheduleDailyNotification(
      id: 1,
      title: "⏰ Daily Reminder",
      body: "Don’t forget to check the app today!",
      hour: 23,
      minute: 0,
  );
  NotificationService().scheduleWeeklyNotification(
    id: 2,
    title: "📅 Weekly Reminder",
    body: "Here’s your weekly update!",
    day: DateTime.sunday,
    hour: 10,
    minute: 0,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final dio = Dio();
        dio.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
          ),
        );

        final postApiService = PostApiService(dio);
        final postRepository = PostRepositoryImpl(service: postApiService);
        final getAllPostsUseCase = GetAllPostsUseCase(repository: postRepository);
        final bloc = PostsBloc(getAllPosts: getAllPostsUseCase);
        bloc.add(GetAllPostsEvent());
        return bloc;
      },
      child: MaterialApp(
        title: 'Local Notifications Demo',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const PostsPage(),
      ),
    );
  }
}