import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_pilot/Helper/Config/app_color.dart';
import 'package:project_pilot/model/instruction.dart';
import 'package:project_pilot/viewmodel/instruction_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstructionScreen extends StatefulWidget {
  final int id;
  final InstructionViewModel instructionViewModel;

  InstructionScreen(this.instructionViewModel, this.id);

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  @override
  void initState() {
    super.initState();
    widget.instructionViewModel.getInstruction(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    widget.instructionViewModel.getInstruction(widget.id);

    return Container(
      padding: EdgeInsets.all(16),
      child: StreamBuilder<Instruction>(
        stream: widget.instructionViewModel.instructionSubject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data == null) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)?.noData ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              } else {
                if (data.steps.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)?.noData ?? '',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: data.steps.length,
                    itemBuilder: (context, index) {
                      return itemListview(index, data);
                    });
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)?.hasError ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.hasError ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          }
        },
      ),
    );
  }

  Container itemListview(int index, Instruction data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: AppColor.black38p),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                (Icons.check_circle),
                color: AppColor.shamrockGreen,
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)?.step ?? ''} ${data.steps[index].step}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 12),
                  ),
                  Text(
                    (data.name ?? '') == '' ? 'Lorem Ipsum' : data.name ?? '',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Color(0xFF00c853),
                        ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Text(
              data.steps[index].description ?? '',
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
