import 'package:chopper/chopper.dart';

part 'doua_api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class DouaApiService extends ChopperService {
  @Get(path: "{urlPath}")
  Future<Response> getOnboarding(
      @Header('Authorization') String authorization, @Path() String urlPath);

  @Get(path: "{urlPath}")
  Future<Response> getAcoes(
      @Header('Authorization') String authorization, @Path() String urlPath);

@Get(path: "{urlPath}")
  Future<Response> getComentario(
      @Header('Authorization') String authorization, @Path() String urlPath);


  @Post(path: "{urlPath}")
  Future<Response> postAcoes(@Header('Authorization') String authorization,
      @Body() Map<String, dynamic> body, @Path() String urlPath);

      @Post(path: "{urlPath}")
  Future<Response> postComentario(@Header('Authorization') String authorization,
      @Body() Map<String, dynamic> body, @Path() String urlPath);

  @Get(path: "{urlPath}")
  Future<Response> getLocals(
      @Header('Authorization') String authorization, @Path() String urlPath);

  @Get(path: "{urlPath}")
  Future<Response> loginGoogle(
      @Header('Authorization') String authorization, @Path() String urlPath);

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
