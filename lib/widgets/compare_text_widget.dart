import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utilities/constants.dart';

class CompareTextWidget extends StatefulWidget {
  const CompareTextWidget({
    required this.title,
    required this.noTitle,
    required this.textStyle,
    required this.list,
    Key? key,
  }) : super(key: key);
  final String title;
  final String noTitle;
  final TextStyle textStyle;
  final List<List<String>> list;

  @override
  State<CompareTextWidget> createState() => _CompareTextWidgetState();
}

class _CompareTextWidgetState extends State<CompareTextWidget> {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildListView(0),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            buildListView(1),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            buildListView(2),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            buildListView(3),
          ],
        ),
      ],
    );
  }

  Expanded buildListView(paramIndex) {
    return Expanded(
      child: widget.list[paramIndex].isEmpty
          ? Center(
              child: Text(
                widget.noTitle,
                style: roboto10redBold,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(height: 2);
                  },
                  shrinkWrap: true,
                  itemCount: widget.list[paramIndex].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      widget.list[paramIndex][index],
                      style: widget.textStyle,
                      textAlign: TextAlign.center,
                    );
                  }),
            ),
    );
  }
}
