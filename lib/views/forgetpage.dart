import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/forgetcontroller.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/controllers/signupcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/models/parking.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/fulltextfield.dart';
import 'package:japark/views/components/primarybutton.dart';
import 'package:japark/views/passworkrecovery.dart';
import 'package:japark/views/signup2page.dart';

import 'components/customappbar.dart';

class ForgetPage extends StatelessWidget {
  ForgetPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  ForgetController forgetController = Get.put(ForgetController());
  TextEditingController textEditingController = TextEditingController();
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
                      onTap: () {
                        forgetController
                            .getQuestion(textEditingController.text);
                        Get.to(PasswordRecovery());
                      },
                      child: Text(
                        'ثبت',
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
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.445,
                          bottom: 5),
                      child: FullTextField(
                        hint: 'ایمیل',
                        textEditingController: textEditingController,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
