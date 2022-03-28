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
            SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: colors[0],
                ),
                child: Text(
                  data[0].toString().replaceAll('.0', ''),
                  style: roboto12blackMedium,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: colors[1],
                ),
                child: Text(
                  data[1].toString().replaceAll('.0', ''),
                  style: roboto12blackMedium,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: colors[2],
                ),
                child: Text(
                  data[2].toString().replaceAll('.0', ''),
                  style: roboto12blackMedium,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: colors[3],
                ),
                child: Text(
                  data[3].toString().replaceAll('.0', ''),
                  style: roboto12blackMedium,
                ),
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ],
    );
  }
}
