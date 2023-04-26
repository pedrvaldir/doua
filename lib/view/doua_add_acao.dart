import 'dart:async';

import 'package:doua/model/doua_acao.dart';
import 'package:doua/model/doua_localizacao.dart';
import 'package:doua/view/home_page.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../utils.dart';
import '../viewmodel/search_viewmodel.dart';

class DouaAddAcaoPage extends StatefulWidget {
  DouaAddAcaoPage() : super();

  @override
  _DouaAddAcaoPageState createState() => _DouaAddAcaoPageState();
}

class _DouaAddAcaoPageState extends State<DouaAddAcaoPage> {
  final int TYPE_DONOR = 2;
  final int TYPE_DONATE = 3;
  bool isLoading = false;
  Location location = Location();
  LatLng? locationSave;
  LocationData? _currentPosition;
  final TextEditingController _controller = TextEditingController();
  GoogleMapController? mapController;
  LatLng _initialcameraposition = LatLng(-25.500753, -49.238138);
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _mapCompletController = Completer();
  int _markerIdCounter = 0;
  final _searchViewModel = SearchViewModel();
  late Marker addMarker;
  late BuildContext mContext;

  @override
  void dispose() {
    mapController?.dispose();
    _controller.dispose();
    super.dispose();
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

    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialcameraposition, zoom: 17)));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      this._loadLocal();
    });
    // _controller.addListener(() {
    //   final String text = _controller.text.toLowerCase();
    //   _controller.value = _controller.value.copyWith(
    //     text: text,
    //     selection:
    //         TextSelection(baseOffset: text.length, extentOffset: text.length),
    //     composing: TextRange.empty,
    //   );
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(DouaSizes.spacingStack15),
          child: Column(
            children: [
              SizedBox(height: DouaSizes.spacing32),
              _header(),
              _title(),
              _body(),
              _map(),
              _description(),
              foot()
            ],
          ),
        ),
      ),
    );
  }

  _map() {
    return Container(
      height: 150.0,
      child: Stack(children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(_markers.values),
          initialCameraPosition: CameraPosition(
            target: _initialcameraposition,
            zoom: 10,
          ),
          onCameraMove: (CameraPosition position) {
            if (_markers.length > 0) {
              MarkerId markerId = MarkerId(_markerIdVal());
              Marker marker = _markers[markerId]!;
              addMarker = marker.copyWith(
                positionParam: position.target,
              );

              setState(() {
                _markers[markerId] = addMarker;
                locationSave = LatLng(
                    addMarker.position.latitude, addMarker.position.longitude);
              });
            }
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
        ),
      ]),
    );
  }

  _body() {
    return DouaImage(
      height: 150.0,
    );
  }

  foot() {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DouaButton.outline(
                  title: "cancelar",
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DouaButton(
                  title: "Salvar",
                  onClick: () async {
                    DouaDialogProgress.showLoading(context, false, "salvando");
                    mContext = context;
                    try {
                      await _searchViewModel.postAcao(DouaAcao(
                          titulo: Constants.DESCRIPTION,
                          descricao: _controller.text,
                          urlImg: "https://picsum.photos/250?image=123",
                          localizacao: DouaLocalizacao(
                              latitude: locationSave!.latitude,
                              longitude: locationSave!.longitude),
                          idTipoAcao:
                              Constants.TYPE_DONOR ? TYPE_DONOR : TYPE_DONATE,
                          qtdVotos: 0));
                      print("salvo");
                    } catch (e) {
                      print("exception");
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage("Doua")),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  _title() {
    return Column(
      children: [
        DouaText.headingTwo(Constants.TYPE_DONOR ? "+ Doando" : "+ Ajudando"),
        DouaText.headingOne(Constants.DESCRIPTION),
      ],
    );
  }

  _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapCompletController.complete(controller);
    mapController = controller;
    if ([_initialcameraposition] != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = _initialcameraposition;
      Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: false,
      );
      setState(() {
        _markers[markerId] = marker;
      });
    }
  }

  _description() {
    return DouaInputField(
      controller: _controller,
    );
  }

  void _loadLocal() {
    getLoc();
  }
}
