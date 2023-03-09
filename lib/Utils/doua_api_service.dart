import 'package:chopper/chopper.dart';

part 'doua_api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class DouaApiService extends ChopperService {

  @Get(path: "{urlPath}")
  Future<Response> getOnboarding(
      @Header('Authorization') String authorization,
      @Path() String urlPath);

      @Get(path: "{urlPath}")
  Future<Response> getAcoes(
      @Header('Authorization') String authorization,
      @Path() String urlPath);

     @Get(path: "{urlPath}")
  Future<Response> getLocals(
      @Header('Authorization') String authorization,
      @Path() String urlPath);

  @Get(path: "{urlPath}")
  Future<Response> loginGoogle(
      @Header('Authorization') String authorization,
      @Path() String urlPath);

  static DouaApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: "https://api-doua.herokuapp.com/",
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
