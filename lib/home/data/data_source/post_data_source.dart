import 'package:flutter_architecture/core/api_client.dart';
import 'package:flutter_architecture/core/api_constant.dart';
import 'package:flutter_architecture/home/data/data_model/post_detail_model.dart';
import 'package:flutter_architecture/home/data/data_model/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postdatasourceProvider = Provider<Postdatasource>((ref) {
  return PostdatasourceImp(ref.watch(apiClientProvider));
});

abstract class Postdatasource {
  Future<List<PostModel>> getPost();
  Future<PostDetailModel> getPostDetail(int id);
}

class PostdatasourceImp extends Postdatasource {
  final ApiClient _apiClient;

  PostdatasourceImp(this._apiClient);
  @override
  Future<List<PostModel>> getPost() async {
    List result = await _apiClient.request(path: ApiConstant.post);
    return result.map((e) => PostModel.fromJson(e)).toList();
  }

  @override
  Future<PostDetailModel> getPostDetail(int id) async {
    final result = await _apiClient.request(path: '${ApiConstant.post}/$id');
    return PostDetailModel.fromJson(result);
  }
}
