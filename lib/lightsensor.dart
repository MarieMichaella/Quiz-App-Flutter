// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightLevel = 0.0;
//   late StreamSubscription<LuxEvent> _lightSensorSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _initLightSensor();
//   }

//   @override
//   void dispose() {
//     _lightSensorSubscription.cancel();
//     super.dispose();
//   }

//   void _initLightSensor() {
//     _lightSensorSubscription = LightSensor.lightSensorEvents.listen((LuxEvent event) {
//       setState(() {
//         _lightLevel = event.lux;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Light Sensor'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Light Level:',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               '${_lightLevel.toStringAsFixed(2)} lux',
//               style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:light/light.dart';
// import 'dart:async';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _currentLux = 0.0;
//   late Light _light;
//   late StreamSubscription<LightEvent> _lightSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _light = Light();
//     _initLightSensor();
//   }

//   void _initLightSensor() async {
//     try {
//       _lightSubscription = _light.lightSensorStream.listen((LightEvent event) {
//         setState(() {
//           _currentLux = event.lux;
//         });
//       });
//     } on LightException catch (e) {
//       print("Error initializing light sensor: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Light Sensor Data'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Current Light Level: $_currentLux lux',
//               style: TextStyle(fontSize: 20.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:light_sensor/light_sensor.dart';


// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   bool _hasSensor = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkSensorAvailability();
//   }

//   Future<void> _checkSensorAvailability() async {
//     _hasSensor = await LightSensor.hasSensor();
//     print('Light sensor available: $_hasSensor');

//     if (_hasSensor) {
//       _subscribeToLuxUpdates();
//     }
//   }

//   void _subscribeToLuxUpdates() {
//     LightSensor.luxStream().listen((lux) {
//       print('Lux value: $lux');
//       // Handle lux value updates here
//       // You can update UI or perform any other actions based on lux value
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Light Sensor Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Lux Value:',
//               style: TextStyle(fontSize: 20),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Check sensor availability again on button press
//                 _checkSensorAvailability();
//               },
//               child: Text('Check Sensor Availability'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';

class LightSensorPage extends StatefulWidget {
  @override
  _LightSensorPageState createState() => _LightSensorPageState();
}

class _LightSensorPageState extends State<LightSensorPage> {
  bool _hasSensor = false;
  double _luxValue = 0.0; 

  @override
  void initState() {
    super.initState();
    _checkSensorAvailability();
  }

  Future<void> _checkSensorAvailability() async {
    _hasSensor = await LightSensor.hasSensor();
    print('Light sensor available: $_hasSensor');

    if (_hasSensor) {
      _subscribeToLuxUpdates();
    }
  }

  void _subscribeToLuxUpdates() {
    LightSensor.luxStream().listen((lux) {
      print('Lux value: $lux');
      setState(() {
        _luxValue = lux.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Sensor Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lux Value: $_luxValue', 
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                _checkSensorAvailability();
              },
              child: Text('Check Sensor Availability'),
            ),
          ],
        ),
      ),
    );
  }
}
