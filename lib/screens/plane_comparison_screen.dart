import 'package:flutter/material.dart';

class PlaneComparisonScreen extends StatefulWidget {
  PlaneComparisonScreen({Key? key, required this.receivedData}) : super(key: key);
  final List<String> receivedData;

  @override
  _PlaneComparisonScreenState createState() => _PlaneComparisonScreenState();
}

class _PlaneComparisonScreenState extends State<PlaneComparisonScreen> {
  final _controller1 = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );
  final _controller2 = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Planes'),
        actions: [
          Icon(Icons.arrow_back),
          Icon(Icons.arrow_back),
          Icon(Icons.arrow_back),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PageView.builder(
                      controller: _controller1,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            widget.receivedData[index].toString(),
                          ),
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
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            widget.receivedData[index].toString(),
                          ),
                        );
                      },
                      itemCount: widget.receivedData.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
