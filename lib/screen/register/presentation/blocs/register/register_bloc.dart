import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:larflut/screen/register/data/models/register_model.dart';
import 'package:larflut/screen/register/domain/services/register_service.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/utils/strings.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _registerService = RegisterService(); //init register service
  RegisterModel? mRegisterModel; //init register model

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      //check internet koneksi
      if (await InternetConnectionChecker().hasConnection) {
        if (event is Register) {
          emit(RegisterLoading());
          try {
            mRegisterModel = await _registerService
                .register(event.params)
                .catchError((error, stackError) {
              print("errror $error");
            }); //mengirim paramter ke service
            emit(RegisterSuccess(mRegisterModel: mRegisterModel));
          } on SocketException {
            emit(RegisterError(
              error: NoInternetException(Strings.noInternet),
            ));
          } on HttpException {
            emit(RegisterError(
              error: NoServiceFoundException(Strings.noServiceFound),
            ));
          } on FormatException {
            emit(RegisterError(
              error: InvalidFormatException(Strings.invalidFormat),
            ));
          } catch (e) {
            emit(RegisterError(
              error: UnknownException(Strings.unknownError),
            ));
          }
        }
      } else {
        emit(RegisterError(
          error: UnknownException(Strings.connectionFailed),
        ));
      }
    });
  }
}
