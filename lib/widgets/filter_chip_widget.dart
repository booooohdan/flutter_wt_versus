import 'package:flutter/material.dart';
import 'package:wt_versus/models/chip_item.dart';
import 'package:wt_versus/utilities/constants.dart';

class FilterChipWidget extends StatefulWidget {
  const FilterChipWidget({required this.list, required this.i, Key? key}) : super(key: key);
  final List<ChipItem> list;
  final int i;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    final list = widget.list;
    final i = widget.i;

    return FilterChip(
      selected: list[i].selected,
      padding: const EdgeInsets.all(4),
      labelStyle: roboto14whiteSemiBold,
      checkmarkColor: Colors.white,
      showCheckmark: true,
      selectedColor: kRed,
      backgroundColor: kTextGreyColor,
      label: Text(list[i].name),
      onSelected: (bool selected) {
        setState(
          () {
            if (selected) {
              list[i].selected = true;
            } else {
              list[i].selected = false;
            }
          },
        );
      },
    );
  }
}
