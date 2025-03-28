import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  int seconds = 0;
  bool isTicking = true;
  Timer? timer;

  /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = 0;
    timer = Timer.periodic(Duration( seconds: 1 ), _onTick);
  }

   */
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
    void _startTimer() {
      timer = Timer.periodic(Duration( seconds: 1 ), _onTick );
      setState(() {
        isTicking = true;
      });
    }

    void _stopTimer(){
      timer?.cancel();
      setState(() {
        isTicking = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>( Colors.red ),
                  foregroundColor: MaterialStateProperty.all<Color>( Colors.white ),
                ),
                child: Text('Start'),
                onPressed: isTicking ? null : _startTimer,
              ),
              SizedBox(width: 20),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>( Colors.red ),
                  foregroundColor: MaterialStateProperty.all<Color>( Colors.white ),
                ),
                child: Text('Stop'),
                onPressed: isTicking ? _stopTimer : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
