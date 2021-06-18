import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/addcarcontroller.dart';
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
              'ورود خودرو',
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
                        if (addCarController.plate1.text.isEmpty ||
                            addCarController.plate2.text.isEmpty ||
                            addCarController.plate3.text.isEmpty ||
                            addCarController.plate4.text.isEmpty ||
                            addCarController.name.text.isEmpty ||
                            addCarController.phone.text.isEmpty ||
                            addCarController.carType.text.isEmpty ||
                            addCarController.duration.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'لطفا فیلد های خالی را پر کنید');
                        }
                        // else if(){}
                        else {
                          await addCarController.addCar().then((value) {
                            if (value) {
                              Get.back();
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
                      hint: 'نام و نام خانوادگی',
                      textEditingController: addCarController.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[آ-ی ]*')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: 'شماره موبایل',
                      textEditingController: addCarController.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: FullTextField(
                      hint: 'نوع خودرو',
                      textEditingController: addCarController.carType,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: FullTextField(
                      hint: 'مدت زمان حدودی پارک (دقیقه)',
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
    );
  }
}
