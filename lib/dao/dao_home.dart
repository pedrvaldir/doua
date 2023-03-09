import 'package:doua/Utils/exceptions.dart';

import '../Utils/constants.dart';
import '../api_response.dart';
import 'package:doua/Utils/doua_api_service.dart';

class DaoHome {
  Future<ApiResponse> getOnboarding() async {
    final chopper = DouaApiService.create();
    List<dynamic> result = [];

    final respRetornlist =
        await chopper.getOnboarding("authorization", EndPoints.getOnboarding);

    if (respRetornlist.statusCode == 200 || respRetornlist.statusCode == 201)
      result = respRetornlist.body;
    else
      throwException(respRetornlist.error.toString());

    return ApiResponse(202, data: result);
  }
}
