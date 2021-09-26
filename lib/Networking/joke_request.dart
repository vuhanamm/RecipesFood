import 'package:dio/dio.dart';
import 'package:project_pilot/networking/network.dart';

class JokeRequest {
  Network network = Network(Dio());

  Future<String> getJoke() async {
    try {
      final response =
          await network.getRequest(path: '/food/jokes/random', params: {});
      String joke = '';
      if (response.statusCode == 200) {
        final result = response.data as Map<String, dynamic>;
        if (result.containsKey('text')) {
          joke = result['text'] as String;
        }
      }
      return joke;
    } catch (e) {
      throw 'Lỗi get joke $e';
    }
  }
}
