import 'package:larflut/screen/register/data/models/register_model.dart';
import 'package:larflut/screen/register/data/repositories/register_repository.dart';

class RegisterService {
  RegisterRepository? _repository;

  RegisterService() {
    _repository = RegisterRepository();
  }

  Future<RegisterModel?> register(params) async {
    RegisterModel? mRegisterModel = await _repository?.register(params);
    return mRegisterModel;
  }
}
