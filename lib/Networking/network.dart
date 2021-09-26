import 'package:dio/dio.dart';
import 'package:project_pilot/Networking/check_connection.dart';
import 'package:project_pilot/networking/constance.dart';

class Network {
  Dio dio;

  var option = BaseOptions(
    baseUrl: Constance.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Network(this.dio) {
    this.dio.options = option;
  }

  Future<Response> getRequest(
      {required String path, required Map<String, dynamic> params}) async {
    try {
      bool checkInternet = await InternetStatus.hasInternet();
      if(checkInternet){
        params.putIfAbsent('apiKey', () => Constance.key);
        return await dio.get(path, queryParameters: params);
      }else{
        return Future.error('No Internet');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
