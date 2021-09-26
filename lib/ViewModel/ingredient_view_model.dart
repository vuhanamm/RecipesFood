import 'package:project_pilot/model/ingredient.dart';
import 'package:project_pilot/networking/ingredient_request.dart';
import 'package:rxdart/rxdart.dart';

class IngredientViewModel {
  BehaviorSubject<List<Ingredient>> listIngredientSubject = BehaviorSubject();

  IngredientRequest req;

  IngredientViewModel(this.req);

  void getIngredient(int id) async {
    List<Ingredient> listResult = await req.getIngredient(id: id);
    listIngredientSubject.sink.add(listResult);
  }

  void dispose() {
    listIngredientSubject.close();
  }
}
