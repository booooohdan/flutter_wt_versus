import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/vehicles.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    required this.receivedData,
    required this.vehicleType,
    Key? key,
  }) : super(key: key);
  final List<Vehicle> receivedData;
  final int? vehicleType;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var selectedRange = RangeValues(6, 10);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 48,
          titleSpacing: 0,
          centerTitle: false,
          title: Text('Filter'),
          leading: CupertinoButton(
            child: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              RangeSlider(
                values: selectedRange,
                onChanged: (newRange) {
                  setState(() => selectedRange = newRange);
                },
                min: 1.0,
                max: 12.0,
                divisions: 110,
                labels: RangeLabels(
                    '${selectedRange.start}', '${selectedRange.end}'),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
