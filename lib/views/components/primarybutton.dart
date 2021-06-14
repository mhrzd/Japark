import 'package:flutter/material.dart';
import 'package:japark/controllers/themecontroller.dart';

class PrimaryButton extends StatelessWidget {
  ThemeController themeController = ThemeController();
  final Widget? child;
  final VoidCallback? onTap;
  PrimaryButton({Key? key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(height: 50.0, width: double.infinity),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              onPrimary: Colors.white,
              primary: themeController.theme.primaryColor,
              shape: StadiumBorder(),
              side: BorderSide(
                  width: 2, color: themeController.theme.primaryColorDark),
              textStyle: TextStyle(
                  fontFamily: 'IranSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            onPressed: () {
              onTap!();
            },
            child: child),
      ),
    );
  }
}
