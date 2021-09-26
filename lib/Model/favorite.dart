import 'package:project_pilot/Helper/Extension/map_extension.dart';
import 'package:project_pilot/Helper/Extension/string_extension.dart';

class Favorite {
  int? id;
  bool? isVegan;
  String? title;
  int? readyInMinutes;
  String? imageUrl;
  String? description;
  int? likesNumber;
  bool? isDairyFree;
  bool? isHealthy;
  bool? isVegetarian;
  bool? isGlutenFree;
  bool? isCheap;

  Favorite(
      {this.id,
      this.likesNumber,
      this.description,
      this.imageUrl,
      this.readyInMinutes,
      this.title,
      this.isVegan});

  Favorite.fromJson(Map<String, dynamic> json) {
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

  Favorite.fromDatabase(Map<String, dynamic> json) {
    this.isVegan = json.toInt('vegan') == 1 ? true : false;
    this.title = json.parseString('title');
    this.readyInMinutes = json.toInt('readyInMinutes');
    this.imageUrl = json.parseString('image');
    this.description = (json.parseString('summary'));
    this.likesNumber = json.toInt('aggregateLikes');
    this.id = json.toInt('id');
  }
}
