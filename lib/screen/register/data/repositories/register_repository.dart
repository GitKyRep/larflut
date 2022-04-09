import 'package:dio/dio.dart';
import 'package:larflut/screen/register/data/models/register_model.dart';

import '../../../../core/network/api_base_helper.dart';

class RegisterRepository {
  ApiBaseHelper api = ApiBaseHelper(); //memanggil class apibasehelper

  Future<RegisterModel?> register(params) async {
    RegisterModel? mRegisterModel; //init register model untuk direturn
    try {
      Response? response = await api.postHTTP(
          "register", params); //request api dengan method POST HTTP
      mRegisterModel = RegisterModel.fromJson(response
          ?.data); //set response kedalam register model yang akan direturn
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return mRegisterModel;
  }
}
