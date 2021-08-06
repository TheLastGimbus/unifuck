import 'dart:async';

import 'package:flutter/material.dart';

class FlashingWarningWidget extends StatefulWidget {
  const FlashingWarningWidget({Key? key}) : super(key: key);

  @override
  _FlashingWarningWidgetState createState() => _FlashingWarningWidgetState();
}

class _FlashingWarningWidgetState extends State<FlashingWarningWidget> {
  late StreamSubscription _flashSS;
  bool _flash = false;

  @override
  void initState() {
    super.initState();
    _flashSS = Stream.periodic(Duration(milliseconds: 300)).listen((event) {
      _flash = !_flash;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 50),
      firstChild: Text(
        "IT'S OVER 9000!!!",
        style: tt.bodyText1!.copyWith(color: Colors.red),
      ),
      secondChild: Text(""),
      crossFadeState:
          _flash ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  @override
  void dispose() {
    _flashSS.cancel();
    super.dispose();
  }
}
