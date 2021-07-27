import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/logincontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/fulltextfield.dart';
import 'package:japark/views/components/primarybutton.dart';
import 'package:japark/views/forgetpage.dart';
import 'package:japark/views/homepage.dart';
import 'package:japark/views/signuppage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: themeController.theme.canvasColor,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Hero(
                tag: 'car',
                child: Image.asset(
                  'assets/car.png',
                  alignment: Alignment.centerRight,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          key: loginController.scaffoldKey,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: PrimaryButton(
                      onTap: () {
                        if (loginController.email.text.isEmpty ||
                            loginController.pass.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'لطفا فیلد های خالی را پر کنید');
                        } else {
                          loginController.login().then((value) {
                            if (value) Get.offAll(HomePage());
                          });
                        }
                      },
                      child: Text(
                        'ورود',
                        textAlign: TextAlign.center,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: AccentButton(
                      onTap: () {
                        Get.to(SignUpPage());
                      },
                      child: Text(
                        'ثبت نام',
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(44.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: 'text',
                        child: Text(
                          'کجاپارک',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: themeController.theme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.28,
                        bottom: 20),
                    child: FullTextField(
                      hint: 'ایمیل',
                      textEditingController: loginController.email,
                    ),
                  ),
                  FullTextField(
                    hint: 'رمزعبور',
                    textEditingController: loginController.pass,
                    obscureText: true,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(ForgetPage());
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 44),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('رمز عبور را فراموش کرده اید؟'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
