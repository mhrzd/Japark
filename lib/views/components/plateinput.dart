import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:japark/controllers/themecontroller.dart';

class PlateInput extends StatefulWidget {
  PlateInput(
      {Key? key,
      this.textEditingController1,
      this.textEditingController2,
      this.textEditingController3,
      this.textEditingController4})
      : super(key: key);
  final TextEditingController? textEditingController1;
  final TextEditingController? textEditingController2;
  final TextEditingController? textEditingController3;
  final TextEditingController? textEditingController4;

  @override
  _PlateInputState createState() => _PlateInputState();
}

class _PlateInputState extends State<PlateInput> {
  ThemeController themeController = ThemeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.textEditingController1!.addListener(() {
      if (widget.textEditingController1!.text.length > 2)
        widget.textEditingController1!.text =
            widget.textEditingController1!.text.substring(0, 2);
    });
    widget.textEditingController2!.addListener(() {
      if (widget.textEditingController2!.text.length > 1)
        widget.textEditingController2!.text =
            widget.textEditingController2!.text.substring(0, 1);
    });
    widget.textEditingController3!.addListener(() {
      if (widget.textEditingController3!.text.length > 3)
        widget.textEditingController3!.text =
            widget.textEditingController3!.text.substring(0, 3);
    });
    widget.textEditingController4!.addListener(() {
      if (widget.textEditingController4!.text.length > 2)
        widget.textEditingController4!.text =
            widget.textEditingController4!.text.substring(0, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(height: 50.0, width: double.infinity),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 18),
                decoration: BoxDecoration(
                    color: themeController.theme.canvasColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 2,
                        color: themeController.theme.primaryColorDark)),
                child: TextField(
                  controller: widget.textEditingController1,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    hintText: '11',
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
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 18),
                decoration: BoxDecoration(
                    color: themeController.theme.canvasColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 2,
                        color: themeController.theme.primaryColorDark)),
                child: TextField(
                  controller: widget.textEditingController2,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.bottom,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[آ-ی]$')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'ب',
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
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 18),
                decoration: BoxDecoration(
                    color: themeController.theme.canvasColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 2,
                        color: themeController.theme.primaryColorDark)),
                child: TextField(
                  controller: widget.textEditingController3,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.bottom,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '111',
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
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 18),
                decoration: BoxDecoration(
                    color: themeController.theme.canvasColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 2,
                        color: themeController.theme.primaryColorDark)),
                child: TextField(
                  controller: widget.textEditingController4,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.bottom,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    hintText: '11',
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
          ],
        ),
      ),
    );
  }
}
