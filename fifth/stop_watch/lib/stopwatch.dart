import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  State<StopWatch> createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  int seconds = 0;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = 0;
    timer = Timer.periodic(Duration( seconds: 10 ), _onTick);
  }
  void _onTick(Timer timer) {
    setState( () {
      ++seconds;
    });
  }

  String _secondsText() => seconds == 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Text(
          '$seconds ${_secondsText()}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
