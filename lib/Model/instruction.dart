import 'package:project_pilot/Helper/Extension/map_extension.dart';

class Instruction{
  String? name;
  List<Steps> steps =[];

  Instruction();

  Instruction.fromJson(Map<String, dynamic> json){
      this.name = json.parseString('name');
      if(json.containsKey('steps')){
        for(var st in json['steps']){
          Steps step = Steps.fromJson(st);
          steps.add(step);
        }
      }
  }
}

class Steps{
  int? step;
  String? description;

  Steps.fromJson(Map<String, dynamic> json){
    this.step = json.toInt('number');
    this.description = json.parseString('step');
  }
}
