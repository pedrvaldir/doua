import 'dart:collection';

import 'package:doua/Utils/prefs.dart';
import 'package:doua/model/doua_acao.dart';
import 'package:doua/model/doua_comentario.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Utils/sliver_appbar_delegate.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/search_viewmodel.dart';
import 'doua_dialog_add.dart';

class LocalsPage extends StatefulWidget {
  const LocalsPage({Key? key}) : super(key: key);

  @override
  _LocalsPageState createState() => _LocalsPageState();
}

class _LocalsPageState extends State<LocalsPage> {
  Location location = Location();
  LocationData? _currentPosition;
  int _markerIdCounter = 1;
  LatLng _initialcameraposition = LatLng(-25.500753, -49.238138);
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController? mapController;
  late List<DouaAcao> listAcoes = [];
  final _searchViewModel = SearchViewModel();
  final _loginViewModel = LoginViewModel();
  var _controller = TextEditingController();
  final TextEditingController _textFieldController = TextEditingController();
  String? codeDialog;
  String? valueText;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this._loadLocals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                zoom: 17,
              ),
              markers: getmarkers(),
              mapType: MapType.normal,
              myLocationEnabled: true,
            ),
          ]),
          floatingActionButton: _addAcao(),
        ));
  }

  Set<Marker> getmarkers() {
    var acao = null;
    setState(() {
      for (DouaAcao acao in listAcoes) {
        _markers.add(_addMarker(acao));
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
        CameraPosition(target: _initialcameraposition, zoom: 13)));
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

  Widget buildSheet(List<DouaComentario> list, DouaAcao acao) =>
      makeDismisssible(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: DouaPallet.kcVeryLightGreyColor,
              child: customScrollView(scrollController, list, acao),
            );
          },
        ),
      ));

  Widget topShowLocation(DouaAcao acao) {
    return Padding(
      padding: const EdgeInsets.only(
          left: DouaSizes.spacing4, right: DouaSizes.spacing4),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
              child: DouaImage(
            base64: acao.urlImg,
            height: 200,
          )),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DouaText.body(acao.descricao!),
          ),
          // Container(
          //   height: 40,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.max,
          //     textDirection: TextDirection.rtl,
          //     children: [
          //       IconButton(
          //         icon: Icon(Icons.favorite),
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       DouaText.subheading(acao.qtdVotos.toString()),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  customScrollView(
      ScrollController _controller, List<DouaComentario> list, DouaAcao acao) {
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
            toolbarHeight: MediaQuery.of(context).size.height * 0.52,
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
                        child:
                            DouaText.headingTitle(acao.titulo!.toUpperCase()),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: DouaText.subheading("Comentários "),
                      ),
                    ],
                  ))),
            )),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Column(
                children: [
                  index < list.length
                      ? WidgetComment(list[index])
                      : SizedBox.fromSize(),
                  if (index == list.length - 1 ||
                      (index == 0 && list.length == 0))
                    widgetAddComentario(context, acao.id),
                ],
              );
            }, childCount: list.length == 0 ? 1 : list.length),
          )
        ],
      ),
    );
  }

  widgetAddComentario(BuildContext context, int? id) {
    return GestureDetector(
      onTap: () async {
        await _displayTextInputDialog(context, id);
        await getLoc();
        await getmarkers();
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 40,
          color: DouaPallet.kcLightGreyColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: DouaText.body("Adicionar Comentário"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context, int? acao) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Comentário'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Adicionar"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Salvar'),
                onPressed: () async {
                  if (valueText != null && valueText!.isNotEmpty) {
                    dynamic doador = await Prefs().getUser();
                    bool result = await _searchViewModel.postComentario(
                        valueText!, acao!, doador);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (result) {
                      valueText = "";
                      _textFieldController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Comentário incluido")));
                    }
                  } else {
                    validateFiled();
                  }
                },
              ),
            ],
          );
        });
  }

  validateFiled() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Preencha todos os campos")));
  }

  Padding WidgetComment(DouaComentario comentarios) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
          height: 80,
          child: Row(
            children: [
              Flexible(
                child: DouaAvatar(url: comentarios.criador!.urlfoto),
                flex: 1,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comentarios.criador!.name!),
                      ],
                    ),
                    Row(
                      children: [
                        DouaText.body(comentarios.descricao!),
                      ],
                    ),
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
    DouaDialogProgress.showLoading(context, false, "Carregando informações");
    getLoc();
    await _loginViewModel.checkUserLogged();
    listAcoes = await _searchViewModel.getAcoes();
    Navigator.pop(context);
    if (!mounted) return;
    setState(() {});
  }

  _addAcao() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      onPressed: () {
        if (_loginViewModel.isLogged) {
          print('Clicked');
          DouaDialogAcao.showInclude(context);
        } else {
          validateField();
        }
      },
    );
  }

  getComentarios(String idAcao) {
    return _searchViewModel.getComentarios(idAcao);
  }

  Marker _addMarker(DouaAcao acao) {
    final MarkerId markerId = MarkerId(acao.id.toString());
    return Marker(
      markerId: markerId,
      position:
          LatLng(acao.localizacao!.latitude!, acao.localizacao!.longitude!),
      infoWindow: InfoWindow(
          title: acao.titulo,
          snippet: acao.descricao,
          onTap: () async {
            _onTapMarker(markerId, acao);
          }),
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  void _onTapMarker(MarkerId markerId, DouaAcao acao) async {
    List<DouaComentario> list = await getComentarios(markerId.value.toString());
    showModalBottomSheet(
      context: context,
      builder: (context) => buildSheet(list, acao),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  validateField() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Somente usuário logado pode incluir ação")));
  }
}
