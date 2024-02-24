import 'package:dio/dio.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../../utils/utils_export.dart';

const googleApiKey = "AIzaSyAxY4CAApKqTGc4EnqvT8-MDGvRaJdDod0";

class UserApi {
  UserApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(),
    );
  }

  DioBase? dioBase;

  Future<dynamic> getUserPlace({
    required String place,
  }) async {
    try {
      var response = await dioBase?.get(
        '/api/place/textsearch/json?query=$place&key=$googleApiKey',
      );

      if (response['results'] != null) {
        return response;
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
