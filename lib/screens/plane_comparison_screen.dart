import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/plane.dart';

class PlaneComparisonScreen extends StatefulWidget {
  PlaneComparisonScreen({Key? key, required this.receivedData}) : super(key: key);
  final List<Plane> receivedData;

  @override
  _PlaneComparisonScreenState createState() => _PlaneComparisonScreenState();
}

class _PlaneComparisonScreenState extends State<PlaneComparisonScreen> {
  int _gameMode = 1;
  int indexController1 = 0;
  int indexController2 = 0;
  int indexController3 = 0;
  int indexController4 = 0;

  final _controller1 = PageController(
    viewportFraction: 0.6,
    initialPage: 1,
  );
  final _controller2 = PageController(
    viewportFraction: 0.6,
    initialPage: 1,
  );
  final _controller3 = PageController(
    viewportFraction: 0.6,
    initialPage: 1,
  );
  final _controller4 = PageController(
    viewportFraction: 0.6,
    initialPage: 1,
  );

  String getSpaceFont(String text) {
    if (text.contains('▃')) {
      return text.replaceAll('▃', '▃     ');
    }
    if (text.contains('␠')) {
      return text.replaceAll('␠', '␠    ');
    }
    if (text.contains('▀')) {
      return text.replaceAll('▀', '▀    ');
    }
    if (text.contains('▂')) {
      return text.replaceAll('▂', '▂    ');
    }
    if (text.contains('▄')) {
      return text.replaceAll('▄', '▄     ');
    }
    if (text.contains('▅')) {
      return text.replaceAll('▅', '▅      ');
    }
    if (text.contains('␗')) {
      return text.replaceAll('␗', '␗     ');
    }
    if (text.contains('')) {
      return text.replaceAll('', '    ');
    }
    return text;
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Planes'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: CupertinoColors.white,
                thumbColor: theme.colorScheme.primary,
                groupValue: _gameMode,
                children: {
                  0: Container(
                    child: Text(
                      'AB',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  1: Container(
                    child: Text(
                      'RB',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  2: Container(
                    child: Text(
                      'SB',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _gameMode = value!;
                  });
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: screenSize.height / 7,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        controller: _controller1,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          indexController1 = index;
                          setState(() {});
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(widget.receivedData[index].image),
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Stack(
                                  children: [
                                    Text(
                                      getSpaceFont(widget.receivedData[index].name),
                                      style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontFamily: 'Symbols'),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: widget.receivedData.length,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        controller: _controller2,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          indexController2 = index;
                          setState(() {});
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(widget.receivedData[index].image),
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Stack(
                                  children: [
                                    Text(
                                      getSpaceFont(widget.receivedData[index].name),
                                      style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontFamily: 'Symbols'),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: widget.receivedData.length,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        controller: _controller3,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          indexController3 = index;
                          setState(() {});
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(widget.receivedData[index].image),
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Stack(
                                  children: [
                                    Text(
                                      getSpaceFont(widget.receivedData[index].name),
                                      style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontFamily: 'Symbols'),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: widget.receivedData.length,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        controller: _controller4,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index) {
                          indexController4 = index;
                          setState(() {});
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(widget.receivedData[index].image),
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Stack(
                                  children: [
                                    Text(
                                      getSpaceFont(widget.receivedData[index].name),
                                      style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontFamily: 'Symbols'),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: widget.receivedData.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.receivedData[indexController1].BRs[_gameMode]),
                Container(height: 20, width: 1, color: Colors.black),
                Text(widget.receivedData[indexController2].BRs[_gameMode]),
                Container(height: 20, width: 1, color: Colors.black),
                Text(widget.receivedData[indexController3].BRs[_gameMode]),
                Container(height: 20, width: 1, color: Colors.black),
                Text(widget.receivedData[indexController4].BRs[_gameMode]),
              ],
            ),
            SizedBox(height: 20.0),
            ExpansionTile(
              title: Text(
                'Flight characteristics',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Text('Max Speed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.receivedData[indexController1].speed),
                    Container(height: 20, width: 1, color: Colors.black),
                    Text(widget.receivedData[indexController2].speed),
                    Container(height: 20, width: 1, color: Colors.black),
                    Text(widget.receivedData[indexController3].speed),
                    Container(height: 20, width: 1, color: Colors.black),
                    Text(widget.receivedData[indexController4].speed),
                  ],
                ),
                Text('Max Altitude', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.receivedData[indexController1].maxAltitude),
                    Container(height: 20, width: 1, color: Colors.black),
                    Text(widget.receivedData[indexController2].maxAltitude),
                    Container(height: 20, width: 1, color: Colors.black),
                    Text(widget.receivedData[indexController3].maxAltitude),
                    Container(height: 20, width: 1, color: Colors.black),
                    Text(widget.receivedData[indexController4].maxAltitude),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Weapons & Turrets',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Text('Weapons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController1].weapons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController1].weapons[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController2].weapons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController2].weapons[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController3].weapons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController3].weapons[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController4].weapons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController4].weapons[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                  ],
                ),
                Text('Turrets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController1].turrets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController1].turrets[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController2].turrets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController2].turrets[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController3].turrets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController3].turrets[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: widget.receivedData[indexController4].turrets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              widget.receivedData[indexController4].turrets[index],
                              style: TextStyle(fontSize: 12),
                            );
                          }),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
