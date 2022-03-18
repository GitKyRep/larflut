import 'package:flutter/material.dart';
import 'package:larflut/core/utils/strings.dart';
import 'package:larflut/core/utils/theme.dart';
import 'package:larflut/core/widgets/custom_button.dart';
import 'package:larflut/core/widgets/custom_textfield.dart';
import 'package:larflut/core/widgets/custom_textfield_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<
      FormState>(); //key untuk form digunakan untuk ketika proses save
  String? username;
  String? password;
  bool _obscureText = true;

  // Toggles show password
  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
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
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/login_image.png",
                        width: MediaQuery.of(context).size.width * .45,
                        height: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Login",
                    style: blackTextStyle.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Silahkan login untuk masuk aplikasi",
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //memanggil wideget customtextfield
                  CustomTextfield(
                    readonly: false,
                    hintText: Strings.username,
                    onSaved: (value) => username = value,
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
                      return null;
                    },
                  ),
                  CustomButton(
                    press: () {
                      final form = _formKey.currentState!;
                      if (form.validate()) {
                        form.save();
                      }
                    },
                    text: "Login",
                    color: primaryColor,
                    textColor: whiteColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
