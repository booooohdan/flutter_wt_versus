import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class CompareIconWidget extends StatefulWidget {
  const CompareIconWidget({
    required this.title,
    required this.data,
    required this.tooltipData,
    Key? key,
  }) : super(key: key);
  final String title;
  final List<String> data;
  final List<String> tooltipData;

  @override
  State<CompareIconWidget> createState() => _CompareIconWidgetState();
}

class _CompareIconWidgetState extends State<CompareIconWidget> {
  double _height = 0.0;
  final _globalKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _height = _globalKey.currentContext!.size!.height;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        widget.title.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  Text(widget.title, style: roboto12greySemiBold),
                  const SizedBox(height: 8),
                ],
              )
            : const SizedBox(height: 0),
        Row(
          key: _globalKey,
          children: [
            Expanded(
              child: Tooltip(
                message: widget.tooltipData[0],
                child: SvgPicture.asset(widget.data[0], height: screenSize.height / 20),
              ),
            ),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            Expanded(
              child: Tooltip(
                message: widget.tooltipData[1],
                child: SvgPicture.asset(widget.data[1], height: screenSize.height / 20),
              ),
            ),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            Expanded(
              child: Tooltip(
                message: widget.tooltipData[2],
                child: SvgPicture.asset(widget.data[2], height: screenSize.height / 20),
              ),
            ),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            Expanded(
              child: Tooltip(
                message: widget.tooltipData[3],
                child: SvgPicture.asset(widget.data[3], height: screenSize.height / 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
