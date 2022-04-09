part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel? mRegisterModel;

  RegisterSuccess({this.mRegisterModel});
}

class RegisterError extends RegisterState {
  final error;

  RegisterError({this.error});
}
