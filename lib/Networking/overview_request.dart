import 'package:dio/dio.dart';
import 'package:project_pilot/model/recipes_overview.dart';
import 'package:project_pilot/networking/network.dart';

class RecipesDetailRequest {
  Network _network = Network(Dio());

  Future<RecipesOverview> getRecipesOverview({required int id}) async {
    try {
      final response = await _network.getRequest(
          path: '/recipes/$id/information', params: {});
      RecipesOverview recipesDetail = RecipesOverview();
      if (response.statusCode == 200) {
        var jsonData = response.data as Map<String, dynamic>;
        if (jsonData.isNotEmpty) {
          recipesDetail = RecipesOverview.fromJson(jsonData);
        }
      }
      return recipesDetail;
    } catch (e) {
      throw 'Lỗi get rc overview $e';
    }
  }


}
