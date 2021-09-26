import 'package:project_pilot/Helper/Extension/map_extension.dart';

class Ingredient {
  String? name;
  String? imageUrl;
  String? metricUnit;
  double? metricValue;
  String? metric;

  Ingredient.fromJson(Map<String, dynamic> json) {
    this.name = json.parseString('name');
    this.imageUrl =
        'https://spoonacular.com/cdn/ingredients_250x250/' + json.parseString('image');
    this.metricUnit = json.toMap('amount').toMap('metric').parseString('unit');
    this.metricValue = json.toMap('amount').toMap('metric').toDouble('value');
    this.metric =
        this.metricValue.toString() + ' ' + this.metricUnit.toString();
  }
}
