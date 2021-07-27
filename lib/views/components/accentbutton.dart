import 'package:flutter/material.dart';
import 'package:japark/controllers/themecontroller.dart';

// ignore: must_be_immutable
class AccentButton extends StatelessWidget {
  ThemeController themeController = ThemeController();
  final Widget? child;
  final VoidCallback? onTap;
  AccentButton({Key? key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints.tightFor(height: 50.0, width: double.infinity),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              onPrimary: themeController.theme.accentColor,
              primary: themeController.theme.canvasColor,
              shape: const StadiumBorder(),
              side: BorderSide(
                  width: 2, color: themeController.theme.accentColor),
              textStyle: const TextStyle(
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
