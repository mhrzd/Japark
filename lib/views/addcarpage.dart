import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/addcarcontroller.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/customappbar.dart';
import 'package:japark/views/components/fulltextfield.dart';
import 'package:japark/views/components/plateinput.dart';
import 'package:japark/views/components/primarybutton.dart';

class AddCarPage extends StatelessWidget {
  AddCarPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  AddCarController addCarController = Get.put(AddCarController());
  ParkingController parkingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        addCarController.clear();
        return true;
      },
      child: Stack(
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
                child: Image.asset(
                  'assets/car.png',
                  alignment: Alignment.centerRight,
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
                      child: SvgPicture.asset('assets/parking_purple.svg'))),
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
                '???????? ??????????',
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
                        onTap: () async {
                          await parkingController.getAllParkingCars();
                          if (plateFormatChecker() ||
                              addCarController.name.text.isEmpty ||
                              addCarController.phone.text.isEmpty ||
                              addCarController.carType.text.isEmpty ||
                              addCarController.duration.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: '???????? ???????? ???? ???? ???? ?????????? ???? ????????');
                          } else if (addCarController.plate1.text
                                  .contains('0') ||
                              addCarController.plate2.text.contains('0') ||
                              addCarController.plate3.text.contains('0')) {
                            Fluttertoast.showToast(
                                msg: '???????? ???????? ???????? ?????? ???????? ????????');
                          } else if (int.parse(
                                  addCarController.duration.text) <=
                              0) {
                            Fluttertoast.showToast(
                                msg: '???????? ???????? ???? ???? ???? ?????????? ???? ????????');
                          } else {
                            if (addCarController.phone.text.length != 11) {
                              Fluttertoast.showToast(
                                  msg: '???????? ?????????? ???????? ???????? ?????? ???????? ????????');
                            } else {
                              bool alreadyin = false;
                              parkingController.cars.forEach((element) {
                                if (element.exited == 0 &&
                                    element.plateNumber ==
                                        addCarController.plate1.text +
                                            addCarController.plate2.text +
                                            addCarController.plate3.text +
                                            addCarController.plate4.text)
                                  alreadyin = true;
                              });
                              if (!alreadyin) {
                                await addCarController.addCar().then((value) {
                                  if (value) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (c) {
                                          return WillPopScope(
                                            onWillPop: () async => false,
                                            child: AlertDialog(
                                              content: Text(
                                                '?????????? ???? ???????? ${addCarController.setFloor() ?? ''} ?????????? ??????',
                                                style: TextStyle(
                                                    color: themeController
                                                        .theme.primaryColor,
                                                    fontFamily: 'IranSans'),
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      addCarController.clear();
                                                      Get.back();
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      '????????',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: themeController
                                                              .theme
                                                              .primaryColor,
                                                          fontFamily:
                                                              'IranSans'),
                                                    ))
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: '?????? ?????????? ???????? ???????? ?????? ?????? ??????');
                              }
                            }
                          }
                        },
                        child: Text(
                          '??????',
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
                          top: MediaQuery.of(context).size.height * 0.445 -
                              kToolbarHeight,
                          bottom: 20),
                      child: PlateInput(
                        textEditingController1: addCarController.plate1,
                        textEditingController2: addCarController.plate2,
                        textEditingController3: addCarController.plate3,
                        textEditingController4: addCarController.plate4,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: FullTextField(
                        hint: '?????? ?? ?????? ????????????????',
                        textEditingController: addCarController.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[??-?? ]*')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: FullTextField(
                        hint: '?????????? ????????????',
                        keyboardType: TextInputType.phone,
                        textEditingController: addCarController.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: FullTextField(
                        hint: '?????? ??????????',
                        textEditingController: addCarController.carType,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: FullTextField(
                        hint: '?????? ???????? ?????????? ???????? (??????????)',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        textEditingController: addCarController.duration,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool plateFormatChecker() {
    if (addCarController.plate1.text.isEmpty ||
        addCarController.plate2.text.isEmpty ||
        addCarController.plate3.text.isEmpty ||
        addCarController.plate4.text.isEmpty) {
      return true;
    } else {
      if (addCarController.plate1.text.length != 2 ||
          addCarController.plate2.text.length != 1 ||
          addCarController.plate3.text.length != 3 ||
          addCarController.plate4.text.length != 2) {
        return true;
      } else {
        return false;
      }
    }
  }
}
