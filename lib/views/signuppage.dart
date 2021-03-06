import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/signupcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/fulltextfield.dart';
import 'package:japark/views/components/primarybutton.dart';
import 'package:japark/views/signup2page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: themeController.theme.canvasColor,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Hero(
                tag: 'car',
                child: Image.asset(
                  'assets/car.png',
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: PrimaryButton(
                      onTap: () async {
                        signUpController.checkEmail().then((value) {
                          if (signUpController.email.text.isEmpty ||
                              signUpController.pass.text.isEmpty ||
                              signUpController.repass.text.isEmpty ||
                              signUpController.question.text.isEmpty ||
                              signUpController.answer.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: '???????? ???????? ?????? ???????? ???? ???? ????????');
                          } else if (signUpController.pass.text !=
                              signUpController.repass.text) {
                            Fluttertoast.showToast(
                                msg: '?????????????? ???? ?????????? ???? ???????????? ????????');
                          } else if (!signUpController.email.text.isEmail) {
                            Fluttertoast.showToast(
                                msg: '???????? ?????????? ???????? ?????? ???????????? ??????');
                          } else if (!value) {
                            Fluttertoast.showToast(
                                msg: '?????????? ???????? ?????? ???????????? ??????');
                          } else {
                            Get.to(SignUp2Page());
                          }
                        });
                      },
                      child: Text(
                        '??????????',
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
                          '??????????????',
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
                      hint: '??????????',
                      textEditingController: signUpController.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: '??????????????',
                      obscureText: true,
                      textEditingController: signUpController.pass,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: '?????????? ??????????????',
                      obscureText: true,
                      textEditingController: signUpController.repass,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: '???????? ?????????????? ??????',
                      textEditingController: signUpController.question,
                    ),
                  ),
                  FullTextField(
                    hint: '???????? ?????????????? ??????',
                    textEditingController: signUpController.answer,
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
