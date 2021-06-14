import 'package:flutter/material.dart';
import 'package:japark/controllers/themecontroller.dart';

class FullTextField extends StatelessWidget {
  FullTextField({Key? key, this.hint = '', this.textEditingController})
      : super(key: key);
  final String hint;
  final TextEditingController? textEditingController;
  ThemeController themeController = ThemeController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(height: 50.0, width: double.infinity),
        child: Container(
          padding: EdgeInsets.only(left: 22, right: 22, top: 18),
          decoration: BoxDecoration(
              color: themeController.theme.canvasColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  width: 2, color: themeController.theme.primaryColorDark)),
          child: TextField(
            controller: textEditingController,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontFamily: 'IranSans',
                fontWeight: FontWeight.bold,
                color: themeController.theme.hintColor,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
