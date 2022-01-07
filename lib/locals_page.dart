import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocalsPage extends StatefulWidget {
  const LocalsPage({Key? key}) : super(key: key);

  @override
  _LocalsPageState createState() => _LocalsPageState();
}

class _LocalsPageState extends State<LocalsPage> {
  GoogleMapController? _controller;
  Location location = Location();
  LocationData? _currentPosition;
  int _markerIdCounter = 1;
  LatLng _initialcameraposition = LatLng(-25.500753, -49.238138);
  Set<Marker> _markers = HashSet<Marker>();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialcameraposition,
              //target: LatLng(-20.131886, -47.484488),
              zoom: 13,
            ),
            markers: getmarkers(),
            mapType: MapType.normal,
            myLocationEnabled: true,
            onTap: (point) {
              _markers.clear();
              _setMarkers(point);
            }),
      ]),
    ));
  }

  Set<Marker> getmarkers() {
    setState(() {
      _markers.add(Marker( 
        markerId: MarkerId('1'),
        position: LatLng(-25.526873, -49.237108), 
        infoWindow: InfoWindow( 
          title: 'MArcador 1 ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));

      _markers.add(Marker( 
        markerId: MarkerId('2'),
        position: LatLng(-25.507333, -49.235974), 
        infoWindow: InfoWindow(
          title: 'Marcador 2',
          snippet: 'Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      _markers.add(Marker( 
        markerId: MarkerId('3'),
        position: LatLng(-25.463612, -49.229548), 
        infoWindow: InfoWindow( 
          title: 'Marcador 3',
          snippet: 'Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, 
      ));
    });
    return _markers;
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      });
    });
  }

  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }
}
