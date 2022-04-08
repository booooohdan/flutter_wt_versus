import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class CompareImagesWidget extends StatefulWidget {
  const CompareImagesWidget({
    required this.title,
    required this.noTitle,
    required this.list,
    //required this.tooltipData,
    Key? key,
  }) : super(key: key);
  final String title;
  final String noTitle;
  final List<List<String>> list;

  //final List<List<String>> tooltipData;

  @override
  State<CompareImagesWidget> createState() => _CompareImagesWidgetState();
}

class _CompareImagesWidgetState extends State<CompareImagesWidget> {
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
    if (screenSize.width > 600) {}

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
            buildGridView(screenSize, 0),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            buildGridView(screenSize, 1),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            buildGridView(screenSize, 2),
            Container(height: _height, width: 1, color: kButtonGreyColor),
            buildGridView(screenSize, 3),
          ],
        ),
      ],
    );
  }

  Expanded buildGridView(Size screenSize, paramIndex) {
    double tabletScreenWidth = screenSize.width - 40;
    if (screenSize.width > 600) {
      tabletScreenWidth = 600;
    }

    return Expanded(
      child: widget.list[paramIndex].isEmpty
          ? Center(
              child: Text(widget.noTitle, style: roboto10redBold),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: tabletScreenWidth / 8,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: widget.list[paramIndex].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Tooltip(
                      message: widget.list[paramIndex][index],
                      child: SvgPicture.asset(
                        'assets/icons/${widget.list[paramIndex][index].replaceAll('/', '')}.svg',
                      ),
                    );
                  }),
            ),
    );
  }
}
