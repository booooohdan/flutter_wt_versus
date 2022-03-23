import 'dart:math';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CompareTilesWidget extends StatelessWidget {
  const CompareTilesWidget(this.data, this.moreIsBetter, {Key? key}) : super(key: key);
  final List<double> data;
  final bool moreIsBetter;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
    final maxVal = data.reduce(max);

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
      }
    }

    moreIsBetter ? setColorForMoreIsBetter() : setColorForLessIsBetter();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 40,
          width: 80,
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
        Container(
          height: 40,
          width: 80,
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
        Container(
          height: 40,
          width: 80,
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
        Container(
          height: 40,
          width: 80,
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
      ],
    );
  }
}
