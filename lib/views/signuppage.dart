import 'package:flutter/material.dart';
import 'package:japark/controllers/themecontroller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: themeController.theme.canvasColor,
          child: Positioned(
            left: MediaQuery.of(context).size.width * -0.5,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Hero(
                  tag: 'car',
                  child: Image.asset(
                    'assets/car.png',
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitWidth,
                  ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
