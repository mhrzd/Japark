import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/signupcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/customappbar.dart';
import 'package:japark/views/components/primarybutton.dart';
import 'package:japark/views/homepage.dart';

import 'components/fulltextfield.dart';

class SignUp2Page extends StatelessWidget {
  SignUp2Page({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  SignUpController signUpController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: themeController.theme.canvasColor,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: SvgPicture.asset(
                    'assets/info.svg',
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          appBar: CustomAppbar(
            action: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                    child: SvgPicture.asset('assets/edit_purple.svg'))),
            leading: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Get.back(),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.width * 0.07,
                      child: SvgPicture.asset('assets/back.svg'))),
            ),
            child: Text(
              'اطلاعات پارکینگ',
              style: TextStyle(
                  color: themeController.theme.primaryColor,
                  fontFamily: 'IranSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: PrimaryButton(
                      onTap: () {
                        if (signUpController.parkingName.text.isEmpty ||
                            signUpController.capacity.text.isEmpty ||
                            signUpController.chargePH.text.isEmpty ||
                            signUpController.enterCharge.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'لطفا فیلد های خالی را پر کنید');
                        } else if (int.parse(signUpController.capacity.text) ==
                                0 ||
                            int.parse(signUpController.chargePH.text) == 0 ||
                            int.parse(signUpController.enterCharge.text) == 0) {
                          Fluttertoast.showToast(
                              msg: 'فیلد ها نمی توانند صفر باشند');
                        } else {
                          signUpController.signUp().then((value) {
                            if (value !=null) {
                              Get.offAll(HomePage());
                            }
                          });
                        }
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
                        bottom: 20),
                    child: FullTextField(
                      hint: 'نام پارکینگ',
                      textEditingController: signUpController.parkingName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: 'ظرفیت',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      textEditingController: signUpController.capacity,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: 'هزینه ثابت (تومان)',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      textEditingController: signUpController.enterCharge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: FullTextField(
                      hint: 'هزینه هر ساعت (تومان)',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      textEditingController: signUpController.chargePH,
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
