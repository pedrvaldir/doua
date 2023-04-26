class DouaLocalizacao {
  int? id;
  double? latitude;
  double? longitude;

  DouaLocalizacao({this.id, this.latitude, this.longitude});

  DouaLocalizacao.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  Map<String, dynamic> toPutMapServidor() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
