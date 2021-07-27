import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/forgetcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/fulltextfield.dart';
import 'package:japark/views/components/primarybutton.dart';


class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  ThemeController themeController = ThemeController();

  ForgetController forgetController = Get.find();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetController>(builder: (_) {
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
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: PrimaryButton(
                      onTap: () {
                        forgetController.check(textEditingController.text);
                      },
                      child: const Text(
                        'ثبت',
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.445,
                            right: 44,
                            left: 44,
                            bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Wrap(children: [
                              Text(
                                'سوال امنیتی: ${forgetController.question}',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: themeController.theme.primaryColor,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              ),
                            ]),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: FullTextField(
                        hint: 'پاسخ سوال امنیتی',
                        textEditingController: textEditingController,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
