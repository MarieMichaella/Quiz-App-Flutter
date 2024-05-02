import 'package:flutter/material.dart';
import 'dart:async';

class SessionTimeoutListener extends StatefulWidget {
  Widget child;
  Duration duration;
  VoidCallback onTimeout;
  SessionTimeoutListener({super.key, required this.child, required this.duration, required this.onTimeout});

  @override
  State<SessionTimeoutListener> createState() => _SessionTimeoutListenerState();
}

class _SessionTimeoutListenerState extends State<SessionTimeoutListener> {
  Timer? _timer;

  _startTimer(){
    print("Timer Reset");
    if(_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
     _timer = Timer(widget.duration, () { 
      print('Elapsed');
      widget.onTimeout();
     });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if(_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        _startTimer();
      },
      child: widget.child,
    );
    
  }
}