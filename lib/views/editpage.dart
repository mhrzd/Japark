import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/controllers/signupcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/customappbar.dart';
import 'package:japark/views/components/primarybutton.dart';
import 'package:japark/views/homepage.dart';

import 'components/fulltextfield.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  ThemeController themeController = ThemeController();

  ParkingController parkingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkingController.setTextFields();
  }

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
              '?????????????? ??????????????',
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
                        if (parkingController.parkingNameT.text.isEmpty ||
                            parkingController.capacityT.text.isEmpty ||
                            parkingController.chargePHT.text.isEmpty ||
                            parkingController.enterChargeT.text.isEmpty ||
                            parkingController.floorsT.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: '???????? ???????? ?????? ???????? ???? ???? ????????');
                        } else if (int.parse(
                                    parkingController.chargePHT.text) <=
                                0 ||
                            int.parse(parkingController.enterChargeT.text) <=
                                0 ||
                            int.parse(parkingController.floorsT.text) <= 0) {
                          Fluttertoast.showToast(
                              msg: '???????? ???? ?????? ???????????? ?????? ??????????');
                        } else {
                          parkingController.editParking().then((value) {
                            if (value != null) {
                              parkingController.upDate();
                              Get.back();
                            }
                          });
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
              child: GetBuilder<ParkingController>(builder: (_) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.445,
                          bottom: 20),
                      child: FullTextField(
                        hint: '?????? ??????????????',
                        textEditingController: parkingController.parkingNameT,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: FullTextField(
                        hint: '??????????',
                        textEditingController: parkingController.capacityT,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: FullTextField(
                        hint: '?????????? ??????????',
                        textEditingController: parkingController.floorsT,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: FullTextField(
                        hint: '?????????? ???????? (??????????)',
                        keyboardType: TextInputType.number,
                        textEditingController: parkingController.enterChargeT,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: FullTextField(
                        hint: '?????????? ???? ???????? (??????????)',
                        keyboardType: TextInputType.number,
                        textEditingController: parkingController.chargePHT,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
