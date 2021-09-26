import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_pilot/Helper/Config/app_color.dart';
import 'package:project_pilot/Helper/Config/app_text_style.dart';
import 'package:rxdart/rxdart.dart';

class ChipFilterWidget extends StatefulWidget {
  final int length;
  final BehaviorSubject<int> subject;
  final List<String> listData;
  final Function changeSelectedItem;
  final bool isShowIcon;

  ChipFilterWidget(
      {required this.length,
      required this.subject,
      required this.listData,
      required this.changeSelectedItem,
      required this.isShowIcon});

  @override
  _ChipFilterWidgetState createState() => _ChipFilterWidgetState();
}

class _ChipFilterWidgetState extends State<ChipFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        widget.length,
        (int index) {
          return StreamBuilder<int>(
              stream: widget.subject,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    avatar: widget.subject.value == index &&
                            widget.isShowIcon == true
                        ? SizedBox(
                            width: 15,
                            child: Icon(
                              Icons.done,
                              color: Color(0xFF651fff),
                            ),
                          )
                        : null,
                    label: Text(
                      '${widget.listData[index]}',
                      style: widget.subject.value == index
                          ? AppTextStyle.textChipSelected
                          : Theme.of(context).textTheme.bodyText2?.copyWith(
                                color: Color(0x90000000),
                              ),
                    ),
                    selected: widget.subject.value == index,
                    onSelected: (bool selected) =>
                        widget.changeSelectedItem(index),
                    selectedColor: AppColor.chipSelected,
                    backgroundColor: AppColor.chipUnSelected,
                  ),
                );
              });
        },
      ).toList(),
    );
  }
}
