import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

// class StepCounterPhone extends StatefulWidget {
//   @override
//   _StepCounterPhoneState createState() => _StepCounterPhoneState();
// }

// class _StepCounterPhoneState extends State<StepCounterPhone> {
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


// void main() {
//   runApp(MaterialApp(home: StepCounterApp()));
// }

// class StepCounterApp extends StatefulWidget {
//   @override
//   _StepCounterAppState createState() => _StepCounterAppState();
// }

// class _StepCounterAppState extends State<StepCounterApp> {
//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   int _stepCount = 0;
//   double _threshold = 1.0;
//   bool _isMovingUp = false;

//   String _pedestrianStatus = 'stopped';
//   bool _permissionGranted = false;

//   String _unit = 'Steps';

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       // Simple step detection based on the threshold
//       if (event.z > _threshold && !_isMovingUp) {
//         _isMovingUp = true;
//         _stepCount++;
//       } else if (event.z < _threshold && _isMovingUp) {
//         _isMovingUp = false;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _stepCountStream.cancel();
//     _pedestrianStatusStream.cancel();
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void onStepCount(StepCount event) {
//     print('Event occurred: $event.toString()');
//     setState(() {
//       _stepCount = event.steps;
//     });
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print('Event occurred: $event.toString()');
//     setState(() {
//       _pedestrianStatus = event.status.toString();
//     });
//   }

//   Future<bool> checkPermission() async {
//     if (await Permission.activityRecognition.request().isGranted) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void initPlatformState() async {
//     if (await checkPermission()) {
//       setState(() {
//         _permissionGranted = true;
//         _stepCountStream = Pedometer.stepCountStream;
//         _stepCountStream.listen(onStepCount);
//         _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//         _pedestrianStatusStream.listen(onPedestrianStatusChanged);
//       });
//     }
//   }

//   String convertStepsTo(String unit) {
//     // Conversion logic here
//   }

//   void showConfigPanel(BuildContext context) {
//     // Configuration panel logic here
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Step Counter'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.settings,
//               color: Colors.white,
//               size: 32,
//             ),
//             onPressed: () {
//               showConfigPanel(context);
//             },
//           )
//         ],
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: _permissionGranted
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     _unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
//                     style: TextStyle(fontSize: _unit.length > 8 ? 32 : 48),
//                   ),
//                   Text(
//                     convertStepsTo(_unit),
//                     style: TextStyle(
//                         fontSize: convertStepsTo(_unit).length > 5 ? 64 : 128),
//                   ),
//                   const Divider(height: 32, color: Colors.black),
//                   Icon(
//                     _pedestrianStatus == 'stopped'
//                         ? Icons.boy_rounded
//                         : _pedestrianStatus == 'walking'
//                             ? Icons.directions_walk
//                             : Icons.error,
//                     size: 128,
//                   ),
//                   Text(_pedestrianStatus != 'unknown'
//                       ? 'You are $_pedestrianStatus'
//                       : 'Unknown pedestrian status'),
//                   Text(
//                     'Accelerometer steps: $_stepCount',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ],
//               )
//             : const AlertDialog(
//                 title: Text('Permission Denied'),
//                 content: Text(
//                     'You must grant activity recognition permission to use this app'),
//               ),
//       ),
//     );
//   }
// }



// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MaterialApp(home: MyApp()));
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;

//   String _steps = '0';
//   String _pedestrianStatus = 'stopped';
//   bool _permissionGranted = false;
//   String _unit = 'Steps';

//   int _stepCount = 0;
//   double _threshold = 1.0;
//   bool _isMovingUp = false;

//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       // Simple step detection based on the threshold
//       if (event.z > _threshold && !_isMovingUp) {
//         _isMovingUp = true;
//         _stepCount++;
//       } else if (event.z < _threshold && _isMovingUp) {
//         _isMovingUp = false;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _stepCountStream.cancel();
//     _pedestrianStatusStream.cancel();
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void onStepCount(StepCount event) {
//     print('Event occurred: $event.toString()');
//     setState(() {
//       _steps = event.steps.toString();
//     });
//   }

//   void onStepCountError(err) {
//     print('Error occurred');
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print('Event occurred: $event.toString()');
//     setState(() {
//       _pedestrianStatus = event.status.toString();
//     });
//   }

//   void onPedestrianStatusError(err) {
//     print('Error occurred: $err');
//     setState(() {
//       _pedestrianStatus = 'unknown';
//     });
//   }

//   Future<bool> checkPermission() async {
//     if (await Permission.activityRecognition.request().isGranted) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void initPlatformState() async {
//     if (await checkPermission()) {
//       setState(() {
//         _permissionGranted = true;
//         _stepCountStream = Pedometer.stepCountStream;
//         _stepCountStream.listen(onStepCount).onError(onStepCountError);
//         _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//         _pedestrianStatusStream
//             .listen(onPedestrianStatusChanged)
//             .onError(onPedestrianStatusError);
//       });
//     }
//   }

//   String convertStepsTo(String unit) {
//     switch (unit) {
//       case 'Kilometers':
//         return (int.parse(_steps) / 1300).toStringAsFixed(1);

//       case 'Meters':
//         return (int.parse(_steps) / 1.3).toStringAsFixed(1);

//       case 'Centimeters':
//         return (int.parse(_steps) / 0.013).toStringAsFixed(1);

//       case 'Inches':
//         return (int.parse(_steps) / 0.03).toStringAsFixed(1);

//       case 'Feet':
//         return (int.parse(_steps) / 0.4).toStringAsFixed(1);

//       case 'Yard':
//         return (int.parse(_steps) / 1.2).toStringAsFixed(1);

//       case 'Miles':
//         return (int.parse(_steps) / 2100).toStringAsFixed(1);
//     }

//     return _steps;
//   }

//   void showConfigPanel(BuildContext context) {
//     ListTile generateOption(String unit, StateSetter setLocalState) {
//       return ListTile(
//         title: Text(unit),
//         leading: Radio(
//           value: unit,
//           groupValue: _unit,
//           onChanged: (value) {
//             setLocalState(() {
//               _unit = value.toString();
//             });

//             setState(() {
//               _unit = value.toString();
//             });
//           },
//         ),
//       );
//     }

//     AlertDialog alert = AlertDialog(
//       title: const Text('Set unit'),
//       content: StatefulBuilder(
//         builder: (BuildContext state, StateSetter setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               generateOption('Steps', setState),
//               generateOption('Kilometers', setState),
//               generateOption('Meters', setState),
//               generateOption('Centimeters', setState),
//               generateOption('Inches', setState),
//               generateOption('Feet', setState),
//               generateOption('Yards', setState),
//               generateOption('Miles', setState)
//             ],
//           );
//         },
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('OK'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         )
//       ],
//     );

//     showDialog(
//       context: context,
//       builder: (BuildContext ctx) {
//         return alert;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Step counter'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.settings,
//                 color: Colors.white,
//                 size: 32,
//               ),
//               onPressed: () {
//                 showConfigPanel(context);
//               },
//             )
//           ],
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           child: _permissionGranted
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       _unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
//                       style: TextStyle(fontSize: _unit.length > 8 ? 32 : 48),
//                     ),
//                     Text(
//                       convertStepsTo(_unit),
//                       style: TextStyle(
//                           fontSize:
//                               convertStepsTo(_unit).length > 5 ? 64 : 128),
//                     ),
//                     const Divider(height: 32, color: Colors.white),
//                     Icon(
//                       _pedestrianStatus == 'stopped'
//                           ? Icons.boy_rounded
//                           : _pedestrianStatus == 'walking'
//                               ? Icons.directions_walk
//                               : Icons.error,
//                       size: 128,
//                     ),
//                     Text(_pedestrianStatus != 'unknown'
//                         ? 'You are $_pedestrianStatus'
//                         : 'Unknown pedestrian status'),
//                     Text(
//                       'Accelerometer steps: $_stepCount',
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ],
//                 )
//               : const AlertDialog(
//                   title: Text('Permission Denied'),
//                   content: Text(
//                       'You must grant activity recognition permission to use this app'),
//                 ),
//         ),
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';


// class StepCounterApp extends StatefulWidget {
//   @override
//   _StepCounterAppState createState() => _StepCounterAppState();
// }

// class _StepCounterAppState extends State<StepCounterApp> {
//   late StreamSubscription<StepCount> _stepCountSubscription;
//   late StreamSubscription<PedestrianStatus> _pedestrianStatusSubscription;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   String _steps = '0';
//   String _pedestrianStatus = 'stopped';
//   bool _permissionGranted = false;
//   String _unit = 'Steps';

//   int _stepCount = 0;
//   double _threshold = 1.0;
//   bool _isMovingUp = false;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       // Simple step detection based on the threshold
//       if (event.z > _threshold && !_isMovingUp) {
//         _isMovingUp = true;
//         _stepCount++;
//       } else if (event.z < _threshold && _isMovingUp) {
//         _isMovingUp = false;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _stepCountSubscription.cancel();
//     _pedestrianStatusSubscription.cancel();
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void onStepCount(StepCount event) {
//     print('Event occurred: $event.toString()');
//     setState(() {
//       _steps = event.steps.toString();
//     });
//   }

//   void onStepCountError(err) {
//     print('Error occurred');
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print('Event occurred: $event.toString()');
//     setState(() {
//       _pedestrianStatus = event.status.toString();
//     });
//   }

//   void onPedestrianStatusError(err) {
//     print('Error occurred: $err');
//     setState(() {
//       _pedestrianStatus = 'unknown';
//     });
//   }

//   Future<bool> checkPermission() async {
//     if (await Permission.activityRecognition.request().isGranted) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void initPlatformState() async {
//     if (await checkPermission()) {
//       setState(() {
//         _permissionGranted = true;
//         _stepCountSubscription = Pedometer.stepCountStream.listen(onStepCount);
//         _stepCountSubscription.onError(onStepCountError);
//         _pedestrianStatusSubscription =
//             Pedometer.pedestrianStatusStream.listen(onPedestrianStatusChanged);
//         _pedestrianStatusSubscription.onError(onPedestrianStatusError);
//       });
//     }
//   }

// void _resetStepCount() {
//   setState(() {
//     _steps = '0';
//     _stepCount = 0; // Reset step count variable
//     _isMovingUp = false; // Reset step detection logic
//   });
// }

//   String convertStepsTo(String unit) {
//     switch (unit) {
//       case 'Kilometers':
//         return (int.parse(_steps) / 1300).toStringAsFixed(1);

//       case 'Meters':
//         return (int.parse(_steps) / 1.3).toStringAsFixed(1);

//       case 'Centimeters':
//         return (int.parse(_steps) / 0.013).toStringAsFixed(1);

//       case 'Inches':
//         return (int.parse(_steps) / 0.03).toStringAsFixed(1);

//       case 'Feet':
//         return (int.parse(_steps) / 0.4).toStringAsFixed(1);

//       case 'Yard':
//         return (int.parse(_steps) / 1.2).toStringAsFixed(1);

//       case 'Miles':
//         return (int.parse(_steps) / 2100).toStringAsFixed(1);
//     }

//     return _steps;
//   }

//   void showConfigPanel(BuildContext context) {
//     ListTile generateOption(String unit, StateSetter setLocalState) {
//       return ListTile(
//         title: Text(unit),
//         leading: Radio(
//           value: unit,
//           groupValue: _unit,
//           onChanged: (value) {
//             setLocalState(() {
//               _unit = value.toString();
//             });

//             setState(() {
//               _unit = value.toString();
//             });
//           },
//         ),
//       );
//     }

//     AlertDialog alert = AlertDialog(
//       title: const Text('Set unit'),
//       content: StatefulBuilder(
//         builder: (BuildContext state, StateSetter setState) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               generateOption('Steps', setState),
//               generateOption('Kilometers', setState),
//               generateOption('Meters', setState),
//               generateOption('Centimeters', setState),
//               generateOption('Inches', setState),
//               generateOption('Feet', setState),
//               generateOption('Yards', setState),
//               generateOption('Miles', setState)
//             ],
//           );
//         },
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('OK'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         )
//       ],
//     );

//     showDialog(
//       context: context,
//       builder: (BuildContext ctx) {
//         return alert;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Step counter'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.settings,
//                 color: Colors.white,
//                 size: 32,
//               ),
//               onPressed: () {
//                 showConfigPanel(context);
//               },
//             )
//           ],
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           child: _permissionGranted
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       _unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
//                       style: TextStyle(fontSize: _unit.length > 8 ? 32 : 48),
//                     ),
//                     Text(
//                       convertStepsTo(_unit),
//                       style: TextStyle(
//                           fontSize:
//                               convertStepsTo(_unit).length > 5 ? 64 : 128),
//                     ),
//                     const Divider(height: 32, color: Colors.white),
//                     Icon(
//                       _pedestrianStatus == 'stopped'
//                           ? Icons.boy_rounded
//                           : _pedestrianStatus == 'walking'
//                               ? Icons.directions_walk
//                               : Icons.error,
//                       size: 128,
//                     ),
//                     Text(_pedestrianStatus != 'unknown'
//                         ? 'You are $_pedestrianStatus'
//                         : 'Unknown pedestrian status'),
//                     Text(
//                       'Accelerometer steps: $_stepCount',
//                       style: TextStyle(fontSize: 24),
//                     ),

//                                         ElevatedButton(
//                       onPressed: _resetStepCount,
//                       child: Text('Reset Step Count'),
//                     ),
//                   ],
//                 )
//               : const AlertDialog(
//                   title: Text('Permission Denied'),
//                   content: Text(
//                       'You must grant activity recognition permission to use this app'),
//                 ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:ffi';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';
// void main() {
// 	runApp(MaterialApp(home: MyApp()));
// }

// class MyApp extends StatefulWidget {
// 	@override
// 	_MyApp createState() => _MyApp();
// }

// class _MyApp extends State<MyApp> {
// 	late Stream<StepCount> _stepCountStream;
// 	late Stream<PedestrianStatus> _pedestrianStatusStream;

// 	String _steps = '0';
// 	String _pedestrianStatus = 'stopped';

// 	bool _permissionGranted = false;

// 	String _unit = 'Steps';

// 	@override
// 	void initState() {
// 		super.initState();
// 		initPlatformState();
// 	}

// 	void onStepCount(StepCount event) {
// 		print('Event occurred: $event.toString()');
// 		setState(() {
// 			_steps = event.steps.toString();
// 		});
// 	}

// 	void onStepCountError(err) {
// 		print('Error occurred');
// 	}

// 	void onPedestrianStatusChanged(PedestrianStatus event) {
// 		print('Event occurred: $event.toString()');
// 		setState(() {
// 			_pedestrianStatus = event.status.toString();
// 		});
// 	}

// 	void onPedestrianStatusError(err) {
// 		print('Error occurred: $err');
// 		setState(() {
// 			_pedestrianStatus = 'unknown';
// 		});
// 	}

// 	Future<bool> checkPermission() async {
// 		if (await Permission.activityRecognition.request().isGranted) {
// 			return true;
// 		} else {
// 			return false;
// 		}
// 	}

// 	void initPlatformState() async {
// 		if (await checkPermission()) {
// 			setState(() { _permissionGranted = true; });

// 			setState(() {
// 				_stepCountStream = Pedometer.stepCountStream;
// 				_stepCountStream
// 					.listen(onStepCount)
// 					.onError(onStepCountError);

// 				_pedestrianStatusStream = Pedometer.pedestrianStatusStream;
// 				_pedestrianStatusStream
// 					.listen(onPedestrianStatusChanged)
// 					.onError(onPedestrianStatusError);
// 			});
// 		}

// 		if (!mounted) return;
// 	}

// 	String convertStepsTo(String unit) {
// 		switch (unit) {
// 			case 'Kilometers':
// 				return (int.parse(_steps) / 1300).toStringAsFixed(1);

// 			case 'Meters':
// 				return (int.parse(_steps) / 1.3).toStringAsFixed(1);

// 			case 'Centimeters':
// 				return (int.parse(_steps) / 0.013).toStringAsFixed(1);

// 			case 'Inches':
// 				return (int.parse(_steps) / 0.03).toStringAsFixed(1);

// 			case 'Feet':
// 				return (int.parse(_steps) / 0.4).toStringAsFixed(1);

// 			case 'Yard':
// 				return (int.parse(_steps) / 1.2).toStringAsFixed(1);

// 			case 'Miles':
// 				return (int.parse(_steps) / 2100).toStringAsFixed(1);
// 		}

// 		return _steps;
// 	}

// 	void showConfigPanel(BuildContext context) {
// 		ListTile generateOption(String unit, StateSetter setLocalState) {
// 			return ListTile(
// 				title: Text(unit),
// 				leading: Radio(
// 					value: unit, 
// 					groupValue: _unit,
// 					onChanged: (value) {
// 						setLocalState(() {
// 							_unit = value.toString();
// 						});

// 						setState(() {
// 							_unit = value.toString();
// 						});
// 					}
// 				)
// 			);
// 		}

// 		AlertDialog alert = AlertDialog(
// 			title: const Text('Set unit'),
// 			content: StatefulBuilder(
// 				builder: (BuildContext state, StateSetter setState) {
// 					return Column(
// 						mainAxisSize: MainAxisSize.min,
// 						children: <Widget>[
// 							generateOption('Steps', setState),
// 							generateOption('Kilometers', setState),
// 							generateOption('Meters', setState),
// 							generateOption('Centimeters', setState),
// 							generateOption('Inches', setState),
// 							generateOption('Feet', setState),
// 							generateOption('Yards', setState),
// 							generateOption('Miles', setState)
// 						]
// 					);
// 				}
// 			),
// 			actions: <Widget>[
// 				TextButton(
// 					child: const Text('OK'),
// 					onPressed: () {
// 						Navigator.pop(context);
// 					}
// 				)
// 			]
// 		);

// 		showDialog(
// 			context: context,
// 			builder: (BuildContext ctx) {
// 				return alert;
// 			}
// 		);
// 	}

// 	@override
// 	Widget build(BuildContext context) {
// 		return MaterialApp(
// 			home: Scaffold(
// 				appBar: AppBar(
// 					title: const Text('Step counter'), 
// 					actions: <Widget>[
// 						IconButton(
// 							icon: const Icon(
// 								Icons.settings,
// 								color: Colors.white,
// 								size: 32,
// 							),
// 							onPressed: () {
// 								showConfigPanel(context);
// 							},
// 						)
// 					],
					
// 				),
// 				body: Container(
// 					alignment: Alignment.center,
// 					child:  _permissionGranted ? 
// 							Column(
// 								mainAxisAlignment: MainAxisAlignment.center,
// 								children: <Widget>[
// 									Text(
// 										_unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
// 										style: TextStyle(
// 											fontSize: _unit.length > 8 ?  32 : 48
// 										)
// 									),
// 									Text(
// 										convertStepsTo(_unit),
// 										style: TextStyle(
// 											fontSize: convertStepsTo(_unit).length > 5 ? 64 : 128
// 										)
// 									),
									
// 									const Divider(height: 32, color: Colors.white),
									
// 									Icon(_pedestrianStatus == 'stopped' ?
// 											Icons.boy_rounded : 
// 											_pedestrianStatus == 'walking' ?
// 												Icons.directions_walk :
// 												Icons.error,
// 										size: 128),
// 									Text(_pedestrianStatus != 'unknown' ?
// 											'You are $_pedestrianStatus' :
// 											'Unknown pedestrian status'),
                  
// 								]
// 							) :
// 							const AlertDialog(
//         						title: Text('Permission Denied'),
//         						content: Text('You must grant activity recognition permission to use this app'),
//       						)
							
// 				),
// 			)
// 		);
// 	}
// }


// import 'dart:ffi';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';
// void main() {
// 	runApp(MaterialApp(home: MyApp()));
// }

// class MyApp extends StatefulWidget {
// 	@override
// 	_MyApp createState() => _MyApp();
// }

// class _MyApp extends State<MyApp> {
// 	late Stream<StepCount> _stepCountStream;
// 	late Stream<PedestrianStatus> _pedestrianStatusStream;

// 	String _steps = '0';
// 	String _pedestrianStatus = 'stopped';

// 	bool _permissionGranted = false;

// 	String _unit = 'Steps';

// 	@override
// 	void initState() {
// 		super.initState();
// 		initPlatformState();
// 	}

// 	void onStepCount(StepCount event) {
// 		print('Event occurred: $event.toString()');
// 		setState(() {
// 			_steps = event.steps.toString();
// 		});
// 	}

// 	void onStepCountError(err) {
// 		print('Error occurred');
// 	}

// 	void onPedestrianStatusChanged(PedestrianStatus event) {
// 		print('Event occurred: $event.toString()');
// 		setState(() {
// 			_pedestrianStatus = event.status.toString();
// 		});
// 	}

// 	void onPedestrianStatusError(err) {
// 		print('Error occurred: $err');
// 		setState(() {
// 			_pedestrianStatus = 'unknown';
// 		});
// 	}

// 	Future<bool> checkPermission() async {
// 		if (await Permission.activityRecognition.request().isGranted) {
// 			return true;
// 		} else {
// 			return false;
// 		}
// 	}

// 	void initPlatformState() async {
// 		if (await checkPermission()) {
// 			setState(() { _permissionGranted = true; });

// 			setState(() {
// 				_stepCountStream = Pedometer.stepCountStream;
// 				_stepCountStream
// 					.listen(onStepCount)
// 					.onError(onStepCountError);

// 				_pedestrianStatusStream = Pedometer.pedestrianStatusStream;
// 				_pedestrianStatusStream
// 					.listen(onPedestrianStatusChanged)
// 					.onError(onPedestrianStatusError);
// 			});
// 		}

// 		if (!mounted) return;
// 	}

// 	String convertStepsTo(String unit) {
// 		switch (unit) {
// 			case 'Kilometers':
// 				return (int.parse(_steps) / 1300).toStringAsFixed(1);

// 			case 'Meters':
// 				return (int.parse(_steps) / 1.3).toStringAsFixed(1);

// 			case 'Centimeters':
// 				return (int.parse(_steps) / 0.013).toStringAsFixed(1);

// 			case 'Inches':
// 				return (int.parse(_steps) / 0.03).toStringAsFixed(1);

// 			case 'Feet':
// 				return (int.parse(_steps) / 0.4).toStringAsFixed(1);

// 			case 'Yard':
// 				return (int.parse(_steps) / 1.2).toStringAsFixed(1);

// 			case 'Miles':
// 				return (int.parse(_steps) / 2100).toStringAsFixed(1);
// 		}

// 		return _steps;
// 	}

// 	void showConfigPanel(BuildContext context) {
// 		ListTile generateOption(String unit, StateSetter setLocalState) {
// 			return ListTile(
// 				title: Text(unit),
// 				leading: Radio(
// 					value: unit, 
// 					groupValue: _unit,
// 					onChanged: (value) {
// 						setLocalState(() {
// 							_unit = value.toString();
// 						});

// 						setState(() {
// 							_unit = value.toString();
// 						});
// 					}
// 				)
// 			);
// 		}

// 		AlertDialog alert = AlertDialog(
// 			title: const Text('Set unit'),
// 			content: StatefulBuilder(
// 				builder: (BuildContext state, StateSetter setState) {
// 					return Column(
// 						mainAxisSize: MainAxisSize.min,
// 						children: <Widget>[
// 							generateOption('Steps', setState),
// 							generateOption('Kilometers', setState),
// 							generateOption('Meters', setState),
// 							generateOption('Centimeters', setState),
// 							generateOption('Inches', setState),
// 							generateOption('Feet', setState),
// 							generateOption('Yards', setState),
// 							generateOption('Miles', setState)
// 						]
// 					);
// 				}
// 			),
// 			actions: <Widget>[
// 				TextButton(
// 					child: const Text('OK'),
// 					onPressed: () {
// 						Navigator.pop(context);
// 					}
// 				)
// 			]
// 		);

// 		showDialog(
// 			context: context,
// 			builder: (BuildContext ctx) {
// 				return alert;
// 			}
// 		);
// 	}

// 	@override
// 	Widget build(BuildContext context) {
// 		return MaterialApp(
// 			home: Scaffold(
// 				appBar: AppBar(
// 					title: const Text('Step counter'), 
// 					actions: <Widget>[
// 						IconButton(
// 							icon: const Icon(
// 								Icons.settings,
// 								color: Colors.white,
// 								size: 32,
// 							),
// 							onPressed: () {
// 								showConfigPanel(context);
// 							},
// 						)
// 					],
					
// 				),
// 				body: Container(
// 					alignment: Alignment.center,
// 					child:  _permissionGranted ? 
// 							Column(
// 								mainAxisAlignment: MainAxisAlignment.center,
// 								children: <Widget>[
// 									Text(
// 										_unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
// 										style: TextStyle(
// 											fontSize: _unit.length > 8 ?  32 : 48
// 										)
// 									),
// 									Text(
// 										convertStepsTo(_unit),
// 										style: TextStyle(
// 											fontSize: convertStepsTo(_unit).length > 5 ? 64 : 128
// 										)
// 									),
									
// 									const Divider(height: 32, color: Colors.white),
									
// 									Icon(_pedestrianStatus == 'stopped' ?
// 											Icons.boy_rounded : 
// 											_pedestrianStatus == 'walking' ?
// 												Icons.directions_walk :
// 												Icons.error,
// 										size: 128),
// 									Text(_pedestrianStatus != 'unknown' ?
// 											'You are $_pedestrianStatus' :
// 											'Unknown pedestrian status'),
                  
// 								]
// 							) :
// 							const AlertDialog(
//         						title: Text('Permission Denied'),
//         						content: Text('You must grant activity recognition permission to use this app'),
//       						)
							
// 				),
// 			)
// 		);
// 	}
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(home: StepCounterApp()));
}

class StepCounterApp extends StatefulWidget {
  @override
  _StepCounterAppState createState() => _StepCounterAppState();
}

class _StepCounterAppState extends State<StepCounterApp> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  String _steps = '0';
  String _pedestrianStatus = 'stopped';
  bool _permissionGranted = false;
  String _unit = 'Steps';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print('Event occurred: $event.toString()');
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(err) {
    print('Error occurred');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print('Event occurred: $event.toString()');
    setState(() {
      _pedestrianStatus = event.status.toString();
    });
  }

  void onPedestrianStatusError(err) {
    print('Error occurred: $err');
    setState(() {
      _pedestrianStatus = 'unknown';
    });
  }

  Future<bool> checkPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  void initPlatformState() async {
    if (await checkPermission()) {
      setState(() {
        _permissionGranted = true;
        _stepCountStream = Pedometer.stepCountStream;
        _stepCountStream.listen(onStepCount).onError(onStepCountError);
        _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
        _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
      });
    }
  }

  String convertStepsTo(String unit) {
    switch (unit) {
      case 'Kilometers':
        return (int.parse(_steps) / 1300).toStringAsFixed(1);
      case 'Meters':
        return (int.parse(_steps) / 1.3).toStringAsFixed(1);
      case 'Centimeters':
        return (int.parse(_steps) / 0.013).toStringAsFixed(1);
      case 'Inches':
        return (int.parse(_steps) / 0.03).toStringAsFixed(1);
      case 'Feet':
        return (int.parse(_steps) / 0.4).toStringAsFixed(1);
      case 'Yard':
        return (int.parse(_steps) / 1.2).toStringAsFixed(1);
      case 'Miles':
        return (int.parse(_steps) / 2100).toStringAsFixed(1);
    }
    return _steps;
  }

  void _resetStepCount() {
    setState(() {
      _steps = '0';
      _pedestrianStatus = 'stopped';
    });
  }

  void showConfigPanel(BuildContext context) {
    ListTile generateOption(String unit, StateSetter setLocalState) {
      return ListTile(
        title: Text(unit),
        leading: Radio(
          value: unit,
          groupValue: _unit,
          onChanged: (value) {
            setLocalState(() {
              _unit = value.toString();
            });
            setState(() {
              _unit = value.toString();
            });
          },
        ),
      );
    }

    AlertDialog alert = AlertDialog(
      title: const Text('Set unit'),
      content: StatefulBuilder(
        builder: (BuildContext state, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              generateOption('Steps', setState),
              generateOption('Kilometers', setState),
              generateOption('Meters', setState),
              generateOption('Centimeters', setState),
              generateOption('Inches', setState),
              generateOption('Feet', setState),
              generateOption('Yards', setState),
              generateOption('Miles', setState)
            ],
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Step counter'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                showConfigPanel(context);
              },
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: _permissionGranted
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _unit == 'Steps' ? '$_unit taken:' : '$_unit walked:',
                      style: TextStyle(fontSize: _unit.length > 8 ? 32 : 48),
                    ),
                    Text(
                      convertStepsTo(_unit),
                      style: TextStyle(fontSize: convertStepsTo(_unit).length > 5 ? 64 : 128),
                    ),
                    const Divider(height: 32, color: Colors.white),
                    Icon(
                      _pedestrianStatus == 'stopped'
                          ? Icons.boy_rounded
                          : _pedestrianStatus == 'walking'
                              ? Icons.directions_walk
                              : Icons.error,
                      size: 128,
                    ),
                    Text(_pedestrianStatus != 'unknown'
                        ? 'You are $_pedestrianStatus'
                        : 'Unknown pedestrian status'),
                    ElevatedButton(
                      onPressed: _resetStepCount,
                      child: Text('Reset Step Count'),
                    ),
                  ],
                )
              : const AlertDialog(
                  title: Text('Permission Denied'),
                  content: Text('You must grant activity recognition permission to use this app'),
                ),
        ),
      ),
    );
  }
}
