import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/primarybutton.dart';
import 'package:japark/views/signuppage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

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
          backgroundColor: Colors.transparent,
          body: SafeArea(
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
                AccentButton(
                    onTap: () {
                      Get.to(SignUpPage());
                    },
                    child: Text(
                      'برو',
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
