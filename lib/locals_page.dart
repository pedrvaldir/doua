import 'dart:collection';

import 'package:doua/model/doua_acao.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'Utils/sliver_appbar_delegate.dart';
import 'viewmodel/search_viewmodel.dart';

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
  GoogleMapController? mapController;
  late List<DouaAcao> listAcoes = [];
  final _searchViewModel = SearchViewModel();

  @override
  void initState() {
    super.initState();

    _loadLocals();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
              target: _initialcameraposition,
              zoom: 13,
            ),
            markers: getmarkers(),
            mapType: MapType.normal,
            myLocationEnabled: true,
            // onTap: (point) {
            //   _markers.clear();
            //   _setMarkers(point);
            // }
            ),
      ]),
    ));
  }

  Set<Marker> getmarkers() {
    setState(() {
      for (var acao in listAcoes) {
        _markers.add(Marker(
          markerId: MarkerId(acao.id.toString()),
          position:
              LatLng(acao.localizacao!.latitude!, acao.localizacao!.longitude!),
          infoWindow: InfoWindow(
              title: acao.titulo,
              snippet: acao.descricao,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => buildSheet(acao),
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                );
              }),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
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

    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialcameraposition, zoom: 13)
        //17 is new zoom level
        ));
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   print("${currentLocation.longitude} : ${currentLocation.longitude}");
    //   if (mounted) {
    //     setState(() {
    //       _currentPosition = currentLocation;
    //       _initialcameraposition =
    //           LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
    //     });
    //   }
    // });
  }

  void _setMarkers(LatLng point) {
    if (mounted) {
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

  Widget makeDismisssible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheet(DouaAcao acao) => makeDismisssible(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: DouaPallet.kcVeryLightGreyColor,
              child: customScrollView(scrollController, acao),
            );
          },
        ),
      ));

  Widget topShowLocation(DouaAcao acao) {
    return Padding(
      padding: const EdgeInsets.only(
          left: DouaSizes.spacing4, right: DouaSizes.spacing4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 0),
              child: Center(
                  child: DouaImage(
                url: acao.urlImg,
                height: MediaQuery.of(context).size.height * 0.15,
              )),
            ),
            DouaText.body(acao.descricao!),
            Container(
              height: 18,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  DouaText.subheading(acao.qtdVotos.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  customScrollView(ScrollController _controller, DouaAcao acao) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: DouaPallet.kcVeryLightGreyColor,
            shadowColor: DouaPallet.kcVeryLightGreyColor,
            pinned: true,
            elevation: 2,
            toolbarHeight: MediaQuery.of(context).size.height * 0.5,
            automaticallyImplyLeading: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: DouaText.headingTitle(acao.titulo!),
                        flex: 2,
                      ),
                      Flexible(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        flex: 0,
                      )
                    ],
                  ),
                  topShowLocation(acao),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
                child: PreferredSize(
              preferredSize: Size.fromHeight(
                40,
              ),
              child: Container(
                  height: 200,
                  color: DouaPallet.kcVeryLightGreyColor,
                  child: Center(
                      child: Row(
                    children: [
                      Icon(Icons.comment_rounded),
                      Text("Comentários "),
                    ],
                  ))),
            )),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index != 4 - 1) {
                  return WidgetComment();
                } else
                  return Container(
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      children: [
                        DouaText.body("Adicionar Comentário"),
                      ],
                    ),
                  );
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Padding WidgetComment() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: DouaAvatar(),
                flex: 1,
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Roberto"),
                      ],
                    ),
                    Text("Lorem lepsum, lorem depsun"),
                  ],
                ),
                flex: 1,
              ),
            ],
          )
          //height: 300,
          ),
    );
  }

  _loadLocals() async {
    getLoc();
    listAcoes = await _searchViewModel.getAcoes();
    if (!mounted) return;
    setState(() {});
  }

  Container buildTest() {
    return Container(
      color: Colors.blue[100],
      child: ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
    );
  }
}
