import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quizapp/simple_map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quizapp/somehome.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
 late GoogleMapController googleMapController;

 static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(-2.074773, 30.087836), zoom: 14 );
 

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User current Location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
         markers:markers, 
         zoomControlsEnabled: false, 
         mapType: MapType.normal, 
         onMapCreated: (GoogleMapController controller){
          googleMapController = controller;
         },),

         floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _determinePosition();
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(-2.074773, 30.087836), zoom:14)));

            markers.clear();

            markers.add(Marker(markerId: const MarkerId("currentLocation"), position:LatLng(-2.074773, 30.087836)));

            setState(() {
              
            });
          }, 
          label: Text("Current Location"), 
          icon: Icon(Icons.location_history),
         ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location service is not enabled');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        return Future.error("Location permission denied");
      }
    }
  if(permission == LocationPermission.deniedForever){
    return Future.error("Location Permissions are permanently denied");

  }

  Position position = await Geolocator.getCurrentPosition();
  return position;
  }
}