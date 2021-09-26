import 'package:project_pilot/Helper/Extension/map_extension.dart';
import 'package:project_pilot/Helper/Extension/string_extension.dart';
class RecipesOverview {
  bool? isDairyFree;
  bool? isHealthy;
  bool? isVegetarian;
  bool? isGlutenFree;
  bool? isCheap;
  int? id;
  bool? isVegan;
  String? title;
  int? readyInMinutes;
  String? imageUrl;
  String? description;
  int? likesNumber;


  RecipesOverview();

  RecipesOverview.fromJson(Map<String, dynamic> json){
    this.isDairyFree = json.toBool('dairyFree');
    this.isHealthy = json.toBool('veryHealthy');
    this.isVegetarian = json.toBool('vegetarian');
    this.isGlutenFree = json.toBool('glutenFree');
    this.isCheap = json.toBool('cheap');
    this.isVegan = json.toBool('vegan');
    this.title = json.parseString('title');
    this.readyInMinutes = json.toInt('readyInMinutes');
    this.imageUrl = json.parseString('image');
    this.description =json.parseString('summary').parseHtmlToString();
    this.likesNumber = json['aggregateLikes'];
    this.id = json.toInt('id');
  }
}