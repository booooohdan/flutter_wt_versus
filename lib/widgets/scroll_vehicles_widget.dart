import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../models/vehicles.dart';
import '../providers/comparison_provider.dart';
import '../utilities/constants.dart';

class ScrollVehiclesWidget extends StatefulWidget {
  const ScrollVehiclesWidget(this.controller, this.receivedData, this.widgetPosition, {Key? key}) : super(key: key);
  final PageController controller;
  final List<Vehicle> receivedData;
  final int widgetPosition;

  @override
  State<ScrollVehiclesWidget> createState() => _ScrollVehiclesWidgetState();
}

class _ScrollVehiclesWidgetState extends State<ScrollVehiclesWidget> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white.withOpacity(0.01)],
          stops: [0.5, 1],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: PageView.builder(
        controller: widget.controller,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          switch (widget.widgetPosition) {
            case 1:
              context.read<ComparisonProvider>().setInt1Value(index);
              break;
            case 2:
              context.read<ComparisonProvider>().setInt2Value(index);
              break;
            case 3:
              context.read<ComparisonProvider>().setInt3Value(index);
              break;
            case 4:
              context.read<ComparisonProvider>().setInt4Value(index);
              break;
          }
          setState(() {});
        },
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.network(widget.receivedData[index].image),
              Padding(
                padding: EdgeInsets.only(
                  top: 35,
                  left: 8,
                  right: 8,
                ),
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: widget.receivedData[index].isPremium ? kYellow : kBlackColor,
                  ),
                  child: Marquee(
                    text: getSpaceFont(widget.receivedData[index].name),
                    velocity: 10,
                    blankSpace: 20.0,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10,
                    style: TextStyle(
                      color: widget.receivedData[index].isPremium ? kBlackColor : Colors.white,
                      fontFamily: 'Symbols',
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: widget.receivedData.length,
      ),
    );
  }
}
