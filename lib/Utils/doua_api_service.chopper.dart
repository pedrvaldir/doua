// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doua_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$DouaApiService extends DouaApiService {
  _$DouaApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DouaApiService;

  @override
  Future<Response<dynamic>> loginGoogle(String authorization, String urlPath) {
    final $url = '${urlPath}';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
