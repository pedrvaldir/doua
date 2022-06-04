

import 'package:chopper/chopper.dart';

part 'doua_api_service.chopper.dart';


@ChopperApi(baseUrl: '')
abstract class DouaApiService extends ChopperService {

  @Get(path: "{urlPath}")
  Future<Response> loginGoogle(
      @Header('Authorization') String authorization,
      @Path() String urlPath);

  static DouaApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: "",
      services: [
        // The generated implementation
        _$DouaApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    return _$DouaApiService(client);
  }
}
