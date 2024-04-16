// import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';

// class StepCounterPage extends StatefulWidget {
//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   String _stepsPerDay = '0';

//   @override
//   void initState() {
//     super.initState();
//     _initPedometer();
//   }

//   void _initPedometer() {
//     Pedometer.stepCountStream.listen((event) {
//       setState(() {
//         _stepsPerDay = event.steps.toString();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Step Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Steps Taken Today:',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               _stepsPerDay,
//               style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:async';
// import 'dart:math';

// class StepCounterPage extends StatefulWidget {
//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   int _stepCount = 0;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _initAccelerometer();
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void _initAccelerometer() {
//     _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
//       // Implement your step detection logic here
//       _detectSteps(event);
//     });
//   }

//   void _detectSteps(AccelerometerEvent event) {
//     // Your custom step detection logic
//     // Example: Detect steps based on changes in acceleration magnitude
//     double magnitude = _calculateAccelerationMagnitude(event);
//     if (magnitude > 15.0) {
//       setState(() {
//         _stepCount++;
//       });
//     }
//   }

//   double _calculateAccelerationMagnitude(AccelerometerEvent event) {
//     return sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Step Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Steps Taken Today:',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               '$_stepCount',
//               style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';
// import 'dart:async';


// class StepCounterPage extends StatefulWidget {
//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   int _stepCount = 0;
//   late StreamSubscription<StepCount> _stepCountSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _initStepCounter();
//   }

//   @override
//   void dispose() {
//     _stepCountSubscription.cancel();
//     super.dispose();
//   }

//   void _initStepCounter() {
//     _stepCountSubscription = Pedometer.stepCountStream.listen((StepCount event) {
//       setState(() {
//         _stepCount = event.steps;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Step Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Steps Taken Today:',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               '$_stepCount',
//               style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//original

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class StepCounterPage extends StatefulWidget {
//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   int _stepCount = 0;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   // Accelerometer data variables
//   List<double> _accelerationValues = [];
//   double _previousPeak = 0.0;
//   double _currentPeak = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _initAccelerometer();
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void _initAccelerometer() {
//     _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
//       _processAccelerometerData(event);
//     });
//   }

//   void _processAccelerometerData(AccelerometerEvent event) {
//     _accelerationValues.add(_calculateAccelerationMagnitude(event));
//     _detectSteps();
//     if (_accelerationValues.length > 50) {
//       _accelerationValues.removeAt(0);
//     }
//   }

//   void _detectSteps() {
//     if (_accelerationValues.length >= 2) {
//       _currentPeak = _findPeak(_accelerationValues);
//       if (_currentPeak > _previousPeak && _currentPeak > 20.0) {
//         setState(() {
//           _stepCount++;
//         });
//         _previousPeak = _currentPeak;
//       }
//     }
//   }

//   double _findPeak(List<double> values) {
//     double peak = 0.0;
//     for (int i = 1; i < values.length; i++) {
//       if (values[i] > values[i - 1] && values[i] > values[i + 1]) {
//         peak = max(peak, values[i]);
//       }
//     }
//     return peak;
//   }

//   double _calculateAccelerationMagnitude(AccelerometerEvent event) {
//     return sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Step Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Steps Taken Today:',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               '$_stepCount',
//               style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';


class StepCounterScreen extends StatefulWidget {
  @override
  _StepCounterScreenState createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  int _stepCount = 0;
  double _threshold = 1.0;
  bool _isMovingUp = false;

  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      // Simple step detection based on the threshold
      if (event.z > _threshold && !_isMovingUp) {
        _isMovingUp = true;
        _stepCount++;
      } else if (event.z < _threshold && _isMovingUp) {
        _isMovingUp = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              '$_stepCount',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}



