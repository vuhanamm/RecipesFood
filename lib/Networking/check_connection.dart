import 'dart:io';

class InternetStatus{
  static Future<bool> hasInternet() async {
      try{
        final response = await InternetAddress.lookup('google.com');
        if(response.isNotEmpty && response.first.rawAddress.isNotEmpty){
          return true;
        }else{
          return false;
        }
      }on SocketException catch(_){
        return false;
      }
  }
}