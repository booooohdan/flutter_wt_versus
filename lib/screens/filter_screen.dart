import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wt_versus/models/chip_item.dart';
import 'package:wt_versus/models/vehicles.dart';
import 'package:wt_versus/providers/firestore_provider.dart';
import 'package:wt_versus/utilities/constants.dart';

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
  List<Vehicle> _vehicleList = [];

  var _selectedRange = RangeValues(6, 10);
  final List<String> _nations = [];
  final List<String> _ranks = [];
  final List<String> _class = [];
  final List<String> _br = [];
  final List<String> _isPremium = [];
  final List<ChipItem> _chipsNations = [];
  final List<ChipItem> _chipsRanks = [];
  final List<ChipItem> _chipsClass = [];
  final List<ChipItem> _chipsBr = [];
  final List<ChipItem> _chipsIsPremium = [];

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
            onPressed: () {
              _applyFilter();
              Navigator.pop(context, _vehicleList);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              RangeSlider(
                values: _selectedRange,
                onChanged: (newRange) {
                  setState(() => _selectedRange = newRange);
                },
                min: 1.0,
                max: 12.0,
                divisions: 110,
                labels: RangeLabels('${_selectedRange.start}', '${_selectedRange.end}'),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  for (var i = 0; i < _nations.length; i++) _filterChipWidget(_chipsNations, i),
                  for (var i = 0; i < _ranks.length; i++) _filterChipWidget(_chipsRanks, i),
                  for (var i = 0; i < _class.length; i++) _filterChipWidget(_chipsClass, i),
                  for (var i = 0; i < _isPremium.length; i++) _filterChipWidget(_chipsIsPremium, i),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _materialBanner(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          leading: Icon(
            Icons.error,
            color: Colors.white,
          ),
          leadingPadding: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          backgroundColor: kRed,
          content: Text(
            'There is no vehicle selected. Please ',
            style: roboto14whiteSemiBold,
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text(
                'Agree',
                style: roboto14whiteSemiBold,
              ),
            ),
          ],
        ),
      );
  }

  FilterChip _filterChipWidget(List<ChipItem> list, int i) {
    return FilterChip(
      selected: list[i].selected,
      padding: const EdgeInsets.all(8),
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

    for (final item in _br) {
      _chipsBr.add(ChipItem(name: item, selected: true));
    }

    for (final item in _isPremium) {
      _chipsIsPremium.add(ChipItem(name: item, selected: true));
    }

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
        //_vehicleList.removeWhere((element) => element.vehicleClass.any((e) => e == item.name));
        _vehicleList.removeWhere((element) => element.vehicleClass.last == item.name);
      }
    }
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
}
