import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/models/chip_item.dart';
import 'package:wt_versus/models/vehicles.dart';
import 'package:wt_versus/providers/firestore_provider.dart';
import 'package:wt_versus/utilities/constants.dart';
import 'package:wt_versus/widgets/filter_chip_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    required this.vehicleType,
    Key? key,
  }) : super(key: key);
  final int? vehicleType;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<Vehicle> _vehicleList = [];

  final List<String> _nations = [];
  final List<String> _ranks = [];
  final List<String> _class = [];
  final List<String> _br = [];
  final List<String> _isPremium = [];
  final List<ChipItem> _chipsNations = [];
  final List<ChipItem> _chipsRanks = [];
  final List<ChipItem> _chipsClass = [];
  final List<ChipItem> _chipsIsPremium = [];
  var _selectedRange = const RangeValues(1.0, 12.0);

  @override
  void initState() {
    super.initState();
    _getVehiclesFromFirebase(widget.vehicleType!)
        .then((value) => _vehicleList.addAll(value))
        .then((value) => _getListsForChips())
        .then((value) => _setChipsData());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 48,
          titleSpacing: 0,
          centerTitle: false,
          title: Text(localizations.filter),
          leading: CupertinoButton(
            child: const Icon(Icons.chevron_left),
            onPressed: () {
              _applyFilter();
              Navigator.pop(context, _vehicleList);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.nations, style: roboto12greySemiBold),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  for (var i = 0; i < _nations.length; i++) FilterChipWidget(list: _chipsNations, i: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.ranks, style: roboto12greySemiBold),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  for (var i = 0; i < _ranks.length; i++) FilterChipWidget(list: _chipsRanks, i: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.vehicleTypes, style: roboto12greySemiBold),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  for (var i = 0; i < _class.length; i++) FilterChipWidget(list: _chipsClass, i: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.battleRatings, style: roboto12greySemiBold),
              ),
              RangeSlider(
                values: _selectedRange,
                onChanged: (newRange) {
                  setState(() => _selectedRange = newRange);
                },
                min: 1.0,
                max: 12.0,
                divisions: 110,
                labels: RangeLabels(
                  '${_selectedRange.start.toStringAsFixed(1)}',
                  '${_selectedRange.end.toStringAsFixed(1)}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.premiumOrNot, style: roboto12greySemiBold),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  for (var i = 0; i < _isPremium.length; i++) FilterChipWidget(list: _chipsIsPremium, i: i),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Vehicle>> _getVehiclesFromFirebase(int vehicleType) async {
    if (vehicleType == 0) {
      return await context.read<FirestoreProvider>().getSimplifiedPlanes();
    }
    if (vehicleType == 1) {
      return await context.read<FirestoreProvider>().getSimplifiedTanks();
    }
    if (vehicleType == 2) {
      return await context.read<FirestoreProvider>().getSimplifiedHelis();
    }
    if (vehicleType == 3) {
      return await context.read<FirestoreProvider>().getSimplifiedShips();
    } else {
      throw 'Exception';
    }
  }

  void _getListsForChips() {
    for (final i in _vehicleList) {
      if (!_nations.contains(i.nation)) {
        _nations.add(i.nation);
      }
    }

    for (final i in _vehicleList) {
      if (!_ranks.contains(i.rank)) {
        _ranks.add(i.rank);
      }
    }

    for (final i in _vehicleList) {
      for (final k in i.vehicleClass) {
        if (!_class.contains(k)) {
          _class.add(k);
        }
      }
    }

    for (final i in _vehicleList) {
      if (!_isPremium.contains(i.isPremium.toString())) {
        _isPremium.add(i.isPremium.toString());
      }
    }

    for (final i in _vehicleList) {
      for (final k in i.BRs) {
        if (!_br.contains(k)) {
          _br.add(k);
        }
      }
    }
  }

  void _setChipsData() {
    for (final item in _nations) {
      _chipsNations.add(ChipItem(name: item, selected: true));
    }

    for (final item in _ranks) {
      _chipsRanks.add(ChipItem(name: item, selected: true));
    }

    for (final item in _class) {
      _chipsClass.add(ChipItem(name: item, selected: true));
    }

    final doubleBr = _br.map((data) => double.parse(data)).toList();
    _selectedRange = RangeValues(doubleBr.reduce(min), doubleBr.reduce(max));

    _chipsIsPremium.add(ChipItem(name: 'Premium', selected: true));
    _chipsIsPremium.add(ChipItem(name: 'Not premium', selected: true));

    _chipsNations.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    _chipsRanks.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    _chipsClass.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    setState(() {});
  }

  void _applyFilter() {
    for (final item in _chipsNations) {
      if (!item.selected) {
        _vehicleList.removeWhere((element) => element.nation == item.name);
      }
    }

    for (final item in _chipsRanks) {
      if (!item.selected) {
        _vehicleList.removeWhere((element) => element.rank == item.name);
      }
    }

    for (final item in _chipsClass) {
      if (!item.selected) {
        _vehicleList.removeWhere((element) => element.vehicleClass.last == item.name);
      }
    }

    for (final item in _br) {
      if (_selectedRange.start > double.parse(item)) {
        _vehicleList.removeWhere((element) => element.BRs[1] == item);
      }
      if (_selectedRange.end < double.parse(item)) {
        _vehicleList.removeWhere((element) => element.BRs[1] == item);
      }
    }

    if (!_chipsIsPremium[0].selected) {
      _vehicleList.removeWhere((element) => element.isPremium);
    }
    if (!_chipsIsPremium[1].selected) {
      _vehicleList.removeWhere((element) => !element.isPremium);
    }
  }
}
