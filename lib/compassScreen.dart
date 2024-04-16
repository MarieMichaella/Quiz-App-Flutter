import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math';

import 'dart:async';

class compassScreen extends StatefulWidget {
  const compassScreen({super.key});

  @override
  State<compassScreen> createState() => _compassScreenState();
}

class _compassScreenState extends State<compassScreen> {
double? heading = 0;
  late StreamSubscription<CompassEvent> compassSubscription;

  @override
  void initState() {
    super.initState();
    compassSubscription = FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  void dispose() {
    compassSubscription.cancel(); // Cancel the subscription
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title:  Text("Compass App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${heading?.ceil()}°", style: TextStyle(color: Colors.white, fontSize:26.0, fontWeight: FontWeight.bold),),
          SizedBox(
            height: 50.0,

          ),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
              Image.asset("assets/images/cadrant.png"),
              Transform.rotate(
                angle: ((heading ?? 0) * (pi /180) * -1),
                child: Image.asset(
                  "assets/images/compass.png",
                  scale:1.1,
                )
                )
              ]
            )
          ),
        ]
      )
      );
  }

}
