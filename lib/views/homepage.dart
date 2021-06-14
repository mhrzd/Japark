import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/customappbar.dart';
import 'package:pie_chart/pie_chart.dart';

import 'components/primarybutton.dart';

class HomePage extends StatelessWidget {
  Map<String, double> data = {'occupied': 27.0, 'free': 73.0};
  HomePage({Key? key}) : super(key: key);
  ThemeController themeController = ThemeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.theme.canvasColor,
      bottomNavigationBar: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: AccentButton(
                  onTap: () {},
                  child: Text(
                    'گزارش ماهانه',
                    textAlign: TextAlign.center,
                  )),
            )
          ],
        ),
      ),
      appBar: CustomAppbar(
        action: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(
                Icons.home_outlined,
                color: themeController.theme.primaryColor,
                size: MediaQuery.of(context).size.width * 0.08,
              )),
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: themeController.theme.accentColor,
                size: MediaQuery.of(context).size.width * 0.08,
              )),
        ),
        child: Text(
          'خانه',
          style: TextStyle(
              color: themeController.theme.primaryColor,
              fontFamily: 'IranSans',
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PieChart(
                  dataMap: data,
                  chartType: ChartType.ring,
                  chartRadius: MediaQuery.of(context).size.width * 0.25,
                  ringStrokeWidth: MediaQuery.of(context).size.width * 0.1,
                  colorList: [
                    themeController.theme.primaryColor,
                    themeController.theme.highlightColor
                  ],
                  chartValuesOptions: ChartValuesOptions(
                    showChartValues: false,
                  ),
                  legendOptions: LegendOptions(showLegends: false)),
              Padding(
                  padding: EdgeInsets.only(
                      //top: MediaQuery.of(context).size.height * 0.445,
                      top: MediaQuery.of(context).size.height * 0.445,
                      bottom: 20),
                  child: PrimaryButton(
                    child: Text(
                      'ورود خودرو',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: PrimaryButton(
                  child: Text(
                    'خروج خودرو',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
