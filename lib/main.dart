// import 'package:flutter/material.dart';
// import 'CalculatorView.dart';
// import 'Aboutscreen.dart';
// import 'homescreen.dart';
// import 'signin.dart';
// import 'themeprovider.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:navigations/signin_user.dart';

// void main() async{
//     WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       builder: (context, _) => const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return MaterialApp(
//           title: 'Navigator',
//           debugShowCheckedModeBanner: false,
//           theme: themeProvider.themeData,
//           darkTheme: ThemeData.dark(),
//           themeMode: themeProvider.themeMode,
//           home: SignInScreen(),
          
//         );
//       },
//     );
//   }
// }




// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @overridetranslucent,translucent,
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return MaterialApp(
//           title: 'Navigator',
//           debugShowCheckedModeBanner: false,
//           theme: themeProvider.themeData,
//           darkTheme: ThemeData.dark(),
//           themeMode: themeProvider.themeMode,
//           home: SignInScreen(),
          
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:quizapp/compassScreen.dart';
import 'package:quizapp/newhome.dart';
import 'package:quizapp/session_timeout.dart';
import 'package:quizapp/somehome.dart';
import 'package:quizapp/stepcounter.dart';
import 'CalculatorView.dart';
import 'Aboutscreen.dart';
import 'homescreen.dart';
import 'signin.dart';
import 'themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizapp/signin_user.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:quizapp/notification_controller.dart';
import 'package:quizapp/firstpage.dart';
import 'package:quizapp/lightsensor.dart';
import 'package:quizapp/googlemapspage.dart';
import 'package:quizapp/session_timeout.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: "basic_channel",
        channelName: "Quiz App",
        channelDescription: "You have a new quiz uploaded",
        )
       ],
    channelGroups:  [
      NotificationChannelGroup(channelGroupKey: "basic_channel_group", channelGroupName: "Quiz App")
    ]
  );

  bool iasAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!iasAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
    NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod: 
    NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
    NotificationController.onDismissActionReceivedMethod

    );
    super.initState();
  }

  
@override
Widget build(BuildContext context) {
  return SessionTimeoutListener(
    duration: const Duration(seconds: 20),
    onTimeout: () {
      print("Time Out");
    }, 
    child: Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Navigator',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: SignInScreen(), 
          // home: compassScreen(),
          // home: StepCounterPage()
          // home: LightSensorPage(),
          // home: GoogleMapPage(),
          // home: LightSensorPage(),
          // home: StepCounterScreen()
        );
      },
    ),
  );
}



}


class NavigationWrapper extends StatefulWidget {
  final Widget child;

  const NavigationWrapper({required this.child});

  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  void handleTimeout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SessionTimeoutListener(
      duration: const Duration(seconds: 60),
      onTimeout: handleTimeout,
      child: widget.child,
    );
  }
}






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



// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// void main() {
//   runApp(MaterialApp(home: MyApp()));
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   StreamSubscription? _accelerometerSubscription;
//   int _stepCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initAccelerometer();
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription?.cancel();
//     super.dispose();
//   }

//   void _initAccelerometer() {
//     _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
//       _detectSteps(event);
//     });
//   }

//   void _detectSteps(AccelerometerEvent event) {
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
//               'Steps Taken:',
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


