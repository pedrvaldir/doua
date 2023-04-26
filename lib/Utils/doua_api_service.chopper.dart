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
  Future<Response<dynamic>> getOnboarding(
      String authorization, String urlPath) {
    final $url = '${urlPath}';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAcoes(String authorization, String urlPath) {
    final $url = '${urlPath}';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postAcoes(
      String authorization, Map<String, dynamic> body, String urlPath) {
    final $url = '${urlPath}';
    final $headers = {
      'Authorization': authorization,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLocals(String authorization, String urlPath) {
    final $url = '${urlPath}';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

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
