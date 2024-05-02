// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class GoogleMapPage extends StatefulWidget {
//   const GoogleMapPage({Key? key}) : super(key: key);

//   @override
//   State<GoogleMapPage> createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPage> {
//   static const googlePlex = LatLng(37.422, -122.084);
//   static const mountainView = LatLng(37.3861, -122.0839);
//   late Location location = Location();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: googlePlex,
//           zoom: 13,
//         ),
//         markers: {
//           const Marker(
//             markerId: MarkerId("sourceLocation"),
//             icon: BitmapDescriptor.defaultMarker,
//             position: googlePlex,
//           ),
//           const Marker(
//             markerId: MarkerId("destinationLocation"),
//             icon: BitmapDescriptor.defaultMarker,
//             position: mountainView,
//           )
//         },
//       ),
//     );


//   }
//       Future<void>  fetchLocationUpdate()async{
//         bool serviceEnabled,
//         PermissionStatus _permissionGranted,

//         serviceEnabled = await locationController.serviceEnabled();
//     }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class GoogleMapPage extends StatefulWidget {
//   const GoogleMapPage({Key? key}) : super(key: key);

//   @override
//   State<GoogleMapPage> createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPage> {
//   static const googlePlex = LatLng(37.422, -122.084);
//   static const mountainView = LatLng(37.3861, -122.0839);
//   late Location location = Location();

//   LatLng? currentPosition;

// @override
// void initState() {
//   super.initState();
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     fetchLocationUpdate();
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: googlePlex,
//           zoom: 13,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId("sourceLocation"),
//             icon: BitmapDescriptor.defaultMarker,
//             position: googlePlex,
//           ),
//           Marker(
//             markerId: MarkerId("destinationLocation"),
//             icon: BitmapDescriptor.defaultMarker,
//             position: mountainView,
//           ),
//         },
//       ),
//     );
//   }

//   Future<void> fetchLocationUpdate() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     location.onLocationChanged.listen((LocationData currentLocation) {
//       if(currentLocation.latitude != null && currentLocation.longitude != null) {
//         setState((){
//           currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  static const googlePlex = LatLng(-2.074773, 30.087836);
  static const mountainView = LatLng(-2.074773, 30.087836);
  late Location location = Location();
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchLocationUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: googlePlex,
          zoom: 13,
        ),
        markers: {
          if (currentPosition != null) // Check if currentPosition is not null
            Marker(
              markerId: MarkerId("userLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: currentPosition!,
            ),
          Marker(
            markerId: MarkerId("destinationLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: mountainView,
          ),
        },
      ),
    );
  }

  Future<void> fetchLocationUpdate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

}
