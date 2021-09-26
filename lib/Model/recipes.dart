import 'package:project_pilot/model/recipes_overview.dart';
import 'package:project_pilot/Helper/Extension/string_extension.dart';
import 'package:project_pilot/Helper/Extension/map_extension.dart';
class Recipes {
  //Recipes Screen
  int? id;
  bool? isVegan;
  String? title;
  int? readyInMinutes;
  String? imageUrl;
  String? description;
  int? likesNumber;

  Recipes();

  Recipes.fromJson(Map<String, dynamic> json) {
    this.isVegan = json.toBool('vegan');
    this.title = json.parseString('title');
    this.readyInMinutes = json.toInt('readyInMinutes');
    this.imageUrl = json.parseString('image');
    this.description = json.parseString('summary').parseHtmlToString();
    this.likesNumber = json.toInt('aggregateLikes');
    this.id = json.toInt('id');
  }

  Map<String, dynamic> toJson() {
    return {
      'vegan': this.isVegan ?? false ? 1 : 0,
      'title': this.title,
      'readyInMinutes': this.readyInMinutes,
      'image': this.imageUrl,
      'summary': this.description,
      'aggregateLikes': this.likesNumber,
      'id': this.id
    };
  }

  Recipes.fromDatabase(Map<String, dynamic> json) {
    this.isVegan = json.toInt('vegan') == 1 ? true : false;
    this.title = json.parseString('title');
    this.readyInMinutes = json.toInt('readyInMinutes');
    this.imageUrl = json.parseString('image');
    this.description = json.parseString('summary').parseHtmlToString();
    this.likesNumber = json.toInt('aggregateLikes');
    this.id = json.toInt('id');
  }

  Recipes.fromRecipesOverview(RecipesOverview rc){
    this.isVegan = rc.isVegan;
    this.title = rc.title;
    this.readyInMinutes = rc.readyInMinutes;
    this.imageUrl = rc.imageUrl;
    this.description = rc.description;
    this.likesNumber = rc.likesNumber;
    this.id = rc.id;
  }
}
