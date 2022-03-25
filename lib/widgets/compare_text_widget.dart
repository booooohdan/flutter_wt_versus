import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CompareTextWidget extends StatelessWidget {
  const CompareTextWidget(this.list, this.noTitle, {Key? key}) : super(key: key);
  final List<List<String>> list;
  final String noTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: list[0].isEmpty
              ? Center(
                  child: Text(
                    noTitle,
                    style: roboto10redRegular,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 2);
                  },
                  shrinkWrap: true,
                  itemCount: list[0].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      list[0][index],
                      style: roboto10blackRegular,
                      textAlign: TextAlign.center,
                    );
                  }),
        ),
        Expanded(
          child: list[1].isEmpty
              ? Center(
                  child: Text(
                    noTitle,
                    style: roboto10redRegular,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 2);
                  },
                  shrinkWrap: true,
                  itemCount: list[1].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      list[1][index],
                      style: roboto10blackRegular,
                      textAlign: TextAlign.center,
                    );
                  }),
        ),
        Expanded(
          child: list[2].isEmpty
              ? Center(
                  child: Text(
                    noTitle,
                    style: roboto10redRegular,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 2);
                  },
                  shrinkWrap: true,
                  itemCount: list[2].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      list[2][index],
                      style: roboto10blackRegular,
                      textAlign: TextAlign.center,
                    );
                  }),
        ),
        Expanded(
          child: list[3].isEmpty
              ? Center(
                  child: Text(
                    noTitle,
                    style: roboto10redRegular,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 2);
                  },
                  shrinkWrap: true,
                  itemCount: list[3].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      list[3][index],
                      style: roboto10blackRegular,
                      textAlign: TextAlign.center,
                    );
                  }),
        ),
      ],
    );
  }
}
