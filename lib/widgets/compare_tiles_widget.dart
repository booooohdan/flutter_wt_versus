import 'dart:math';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CompareTilesWidget extends StatelessWidget {
  const CompareTilesWidget({
    required this.title,
    required this.moreIsBetter,
    required this.data,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool moreIsBetter;
  final List<double> data;

  @override
  Widget build(BuildContext context) {
    final maxVal = data.reduce(max);
    final List<Color> colors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];

    void setColorForMoreIsBetter() {
      for (var i = 0; i < data.length; i++) {
        final a = (data[i] / maxVal) * 100;
        if (a > 95) {
          colors[i] = kGreen;
        } else if (a > 85) {
          colors[i] = kLightGreen;
        } else if (a > 75) {
          colors[i] = kYellow;
        } else {
          colors[i] = kRed;
        }

        if (data[i] == 0.0) {
          colors[i] = Colors.white;
        }
      }
    }

    void setColorForLessIsBetter() {
      for (var i = 0; i < data.length; i++) {
        final a = (data[i] / maxVal) * 100;
        if (a > 95) {
          colors[i] = kRed;
        } else if (a > 85) {
          colors[i] = kYellow;
        } else if (a > 75) {
          colors[i] = kLightGreen;
        } else {
          colors[i] = kGreen;
        }

        if (data[i] == 0.0) {
          colors[i] = Colors.white;
        }
      }
    }

    moreIsBetter ? setColorForMoreIsBetter() : setColorForLessIsBetter();

    return Column(
      children: [
        title.isNotEmpty
            ? Column(
                children: [
                  SizedBox(height: 8),
                  Text(title, style: roboto12greySemiBold),
                  SizedBox(height: 8),
                ],
              )
            : SizedBox(height: 0),
        Row(
          children: [
            SizedBox(width: 4),
            buildColoredTile(colors, 0),
            SizedBox(width: 8),
            buildColoredTile(colors, 1),
            SizedBox(width: 8),
            buildColoredTile(colors, 2),
            SizedBox(width: 8),
            buildColoredTile(colors, 3),
            SizedBox(width: 4),
          ],
        ),
      ],
    );
  }

  Expanded buildColoredTile(List<Color> colors, paramIndex) {
    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: colors[paramIndex],
        ),
        child: Text(
          data[paramIndex].toString().replaceAll('.0', ''),
          style: roboto12blackMedium,
        ),
      ),
    );
  }
}
