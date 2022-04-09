part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegisterEvent {
  //tipe data parameter yang digunakan untuk proses post request
  final FormData params;

  const Register(this.params);

  @override
  List<Object> get props => [params];
}
