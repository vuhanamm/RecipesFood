import 'package:dio/dio.dart';
import 'package:project_pilot/model/ingredient.dart';
import 'package:project_pilot/networking/network.dart';

class IngredientRequest {
  Network _network = Network(Dio());

  Future<List<Ingredient>> getIngredient({required int id}) async {
    try {
      final response = await _network
          .getRequest(path: '/recipes/$id/ingredientWidget.json', params: {});
      List<Ingredient> list = [];
      if (response.statusCode == 200) {
        final result = response.data as Map<String, dynamic>;
        if (result.containsKey('ingredients')) {
          var listResult = result['ingredients'];
          if (listResult.isNotEmpty) {
            for (var json in listResult) {
              Ingredient ingredient = Ingredient.fromJson(json);
              list.add(ingredient);
            }
          }
        }
      }
      return list;
    } catch (e) {
      throw "Lỗi get Ingredien: $e";
    }
  }
}
