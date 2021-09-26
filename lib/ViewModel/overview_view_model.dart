import 'package:project_pilot/model/recipes_overview.dart';
import 'package:project_pilot/networking/overview_request.dart';
import 'package:rxdart/rxdart.dart';

class OverviewViewModel {
  BehaviorSubject<RecipesOverview> recipesSubject = BehaviorSubject();

  RecipesDetailRequest req;

  OverviewViewModel(this.req);

  void getRecipesOverview(int id) async {
    RecipesOverview rp = await req.getRecipesOverview(id: id);
    recipesSubject.sink.add(rp);
  }

  void dispose() {
    recipesSubject.close();
  }
}
