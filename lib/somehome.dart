// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:navigations/current_location.dart';
// import 'package:navigations/simple_map_screen.dart';

// class Geolocator extends StatefulWidget {
//   const Geolocator({super.key});

//   @override
//   State<Geolocator> createState() => _GeolocatorState();
// }

// class _GeolocatorState extends State<Geolocator> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Google Maps"),
//         centerTitle: true,
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//     ElevatedButton(
//       onPressed: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (BuildContext context) {
//             return const SimpleMapScreen();
//           },
//         ));
//       },
//       child: const Text('Open Map'),
//     ),

//         ElevatedButton(
//       onPressed: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (BuildContext context) {
//             return const CurrentLocation();
//           },
//         ));
//       },
//       child: const Text('Open Map'),
//     ),

//           ]
//         )
//       )
//     );
//   }
// }