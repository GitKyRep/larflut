import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:larflut/core/utils/strings.dart';
import 'package:larflut/core/utils/theme.dart';
import 'package:larflut/core/widgets/custom_button.dart';
import 'package:larflut/core/widgets/custom_textfield.dart';
import 'package:larflut/core/widgets/custom_textfield_password.dart';
import 'package:larflut/screen/register/presentation/blocs/register/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<
      FormState>(); //key untuk form digunakan untuk ketika proses save
  String? name;
  String? email;
  String? password;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  // Toggles show password
  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/register_image.png",
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register",
                    style: blackTextStyle.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Silahkan Daftar terlebih dahulu",
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //memanggil wideget customtextfield
                  CustomTextfield(
                    readonly: false,
                    hintText: Strings.name,
                    onSaved: (value) => name = value,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return Strings.errorEmpty;
                      }
                      if (value.length < 4) {
                        return "Nama minimal 4 karakter";
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    readonly: false,
                    hintText: Strings.email,
                    onSaved: (value) => email = value,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return Strings.errorEmpty;
                      }
                      return null;
                    },
                  ),
                  CustomTextfieldPassword(
                    hintText: Strings.password,
                    onSaved: (value) => password = value,
                    obscureText: _obscureText,
                    togglePassword: _togglePassword,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return Strings.errorEmpty;
                      }
                      if (value.length < 8) {
                        return "Password harus lebih dari 8 karakter";
                      }
                      return null;
                    },
                  ),
                  CustomButton(
                    press: () {
                      final form =
                          _formKey.currentState!; //get current state form
                      //check validate form
                      if (form.validate()) {
                        form.save(); //set form save
                        _register(); //call method register
                      }
                    },
                    text: "Register",
                    color: primaryColor,
                    textColor: whiteColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already have an account ? ",
                        style: blackTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          //pindah halaman ke form register
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: Text(
                          Strings.login,
                          style: blackTextStyle.copyWith(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  //get action when get response with bloc listener
                  BlocListener<RegisterBloc, RegisterState>(
                    listener: (_, response) {
                      //when response get error
                      if (response is RegisterError) {
                        final error = response.error;
                        String? message = error.message;
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.TOPSLIDE,
                          headerAnimationLoop: false,
                          dialogType: DialogType.ERROR,
                          showCloseIcon: false,
                          dismissOnTouchOutside: false,
                          title: Strings.error,
                          desc: message,
                          btnOkText: Strings.ok,
                          btnOkOnPress: () {},
                        ).show();
                      }
                      //when state bloc is register success
                      if (response is RegisterSuccess) {
                        //when response get success is true
                        if (response.mRegisterModel?.success ?? false) {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.TOPSLIDE,
                            headerAnimationLoop: false,
                            dialogType: DialogType.SUCCES,
                            showCloseIcon: false,
                            dismissOnTouchOutside: false,
                            title: Strings.success,
                            desc: response.mRegisterModel!.message,
                            btnOkText: Strings.ok,
                            btnOkOnPress: () {
                              Navigator.pushReplacementNamed(context, "/login");
                            },
                          ).show();
                        } else {
                          //when response get success is false
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.TOPSLIDE,
                            headerAnimationLoop: false,
                            dialogType: DialogType.INFO,
                            showCloseIcon: false,
                            dismissOnTouchOutside: false,
                            title: Strings.information,
                            desc: response.mRegisterModel!.message,
                            btnOkText: Strings.ok,
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                    },
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _register() async {
    EasyLoading.show(status: Strings.pleaseWait); //show loading
    Future.delayed(const Duration(seconds: 3)).then((value) {
      //init params with data type form data
      FormData params = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
      });
      context
          .read<RegisterBloc>()
          .add(Register(params)); //call bloc with event register
      EasyLoading.dismiss(); //close loading when get response
    });
  }
}
