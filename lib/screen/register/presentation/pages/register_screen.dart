import 'package:flutter/material.dart';
import 'package:larflut/core/utils/strings.dart';
import 'package:larflut/core/utils/theme.dart';
import 'package:larflut/core/widgets/custom_button.dart';
import 'package:larflut/core/widgets/custom_textfield.dart';
import 'package:larflut/core/widgets/custom_textfield_password.dart';

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
                    obscureText: false,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
