import 'package:dio/dio.dart';
import 'package:project_pilot/model/instruction.dart';
import 'package:project_pilot/networking/network.dart';

class InstructionRequest {
  Network _network = Network(Dio());

  Future<Instruction> getInstruction({required int id}) async {
    try {
      final response = await _network.getRequest(path: '/recipes/$id/analyzedInstructions', params: {});
      Instruction instruction = Instruction();
      if (response.statusCode == 200) {
        final res = response.data as List<dynamic>;
        if (res.isNotEmpty) {
          final result = res[0];
          if (result.containsKey('name')) {
            instruction.name = result['name'];
          }
          List<Steps> listStep = [];
          if (result.containsKey('steps')) {
            var list = result['steps'];
            for (var json in list) {
              Steps step = Steps.fromJson(json);
              listStep.add(step);
            }
          }
          instruction.steps = listStep;
        }
      }
      return instruction;
    } catch (e) {
      throw 'Lỗi get Instructor $e';
    }
  }
}
