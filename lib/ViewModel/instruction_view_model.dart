import 'package:project_pilot/model/instruction.dart';
import 'package:project_pilot/networking/instruction_request.dart';
import 'package:rxdart/rxdart.dart';

class InstructionViewModel {
  BehaviorSubject<Instruction> instructionSubject = BehaviorSubject();

  InstructionRequest req;

  InstructionViewModel(this.req);

  void getInstruction(int id) async {
    Instruction instruction = await req.getInstruction(id: id);
    instructionSubject.sink.add(instruction);
  }

  void dispose() {
    instructionSubject.close();
  }
}
