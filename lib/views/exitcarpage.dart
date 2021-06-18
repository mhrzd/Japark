import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/exitcarcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/customappbar.dart';
import 'package:japark/views/components/fulltextfield.dart';
import 'package:japark/views/components/plateinput.dart';
import 'package:japark/views/components/primarybutton.dart';

class ExitCarPage extends StatelessWidget {
  ExitCarPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  ExitCarController exitCarController = Get.put(ExitCarController());
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
              child: Image.asset(
                'assets/car.png',
                alignment: Alignment.centerLeft,
                fit: BoxFit.fitHeight,
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
                    child: SvgPicture.asset('assets/exit_purple.svg'))),
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
              'خروج خودرو',
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
                        exitCarController.exitCar().then((value) {
                          if (value) {
                            Get.back();
                          }
                        });
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
                    child: PlateInput(
                      textEditingController1: exitCarController.plate1,
                      textEditingController2: exitCarController.plate2,
                      textEditingController3: exitCarController.plate3,
                      textEditingController4: exitCarController.plate4,
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
