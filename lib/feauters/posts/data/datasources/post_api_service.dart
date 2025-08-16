import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts/feauters/posts/data/models/post_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/api_constant.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl:ApiConstant.baseUrl)
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET(ApiConstant.posts)
  Future<List<PostModel>> getAllPosts();

  @POST(ApiConstant.posts)
  Future<HttpResponse<void>> addPost(@Body() PostModel post);

  @PATCH("${ApiConstant.posts}/{id}")
  Future<HttpResponse<void>> updatePost(@Path("id") int id , @Body() PostModel post);

  @DELETE("${ApiConstant.posts}/{id}")
  Future<HttpResponse<void>> deletePost(@Path("id") int id);
}
