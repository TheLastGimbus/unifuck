import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'widgets/flashing_warning_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unifuck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _touched = false;
  int _spierdolenieLevel = 0;
  static const _maxSpierdolenieLevel = 300;
  late StreamSubscription _spierdolenieSS;

  bool get _over9000 => _spierdolenieLevel > (_maxSpierdolenieLevel * 2 / 3);

  @override
  void initState() {
    super.initState();
    _spierdolenieSS =
        Stream.periodic(Duration(milliseconds: 10)).listen((event) {
      if (_spierdolenieLevel > 0) {
        _spierdolenieLevel--;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text("Unifuck - Gej Dev Simulator")),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [
                  Text("Poziom spierdolenia Unity:"),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _spierdolenieLevel / 300,
                      color: _over9000 ? Colors.red : null,
                    ),
                  ),
                  SizedBox(height: 8),
                  if (_over9000) FlashingWarningWidget(),
                ],
              ),
            ),
            Text(
              'Jebałeś sie z Unity:',
              style: tt.headline3,
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTapDown: (_) => setState(() => _touched = true),
              onTapUp: (_) => setState(() => _touched = false),
              onTap: () {
                _counter++;
                _spierdolenieLevel += 10;
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 3000),
                width: _touched ? 500 : 70,
                height: _touched ? 500 : 70,
                child: Image.asset(
                  'assets/unity.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text('$_counter', style: tt.headline2),
            Text('razy', style: tt.bodyText1),
            SizedBox(height: 16),
            Text('...a i tak nie działa'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _spierdolenieSS.cancel();
    super.dispose();
  }
}
