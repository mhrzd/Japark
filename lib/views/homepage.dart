import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';

import 'package:japark/controllers/themecontroller.dart';
import 'package:japark/views/addcarpage.dart';
import 'package:japark/views/components/accentbutton.dart';
import 'package:japark/views/components/customappbar.dart';
import 'package:japark/views/editpage.dart';
import 'package:japark/views/signup2page.dart';
import 'package:japark/views/reportpage.dart';
import 'package:japark/views/exitcarpage.dart';
import 'package:pie_chart/pie_chart.dart';

import 'components/primarybutton.dart';

class HomePage extends StatelessWidget {
  ParkingController parkingController = Get.find();
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
                  onTap: () {
                    Get.to(ReportPage());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          margin: EdgeInsets.only(right: 10),
                          child: SvgPicture.asset('assets/graph_yellow.svg')),
                      Text(
                        'گزارش ماهانه',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
      appBar: CustomAppbar(
        action: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: SvgPicture.asset('assets/home_purple.svg'))),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Get.to(EditPage()),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  child: SvgPicture.asset('assets/edit_yellow.svg'))),
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
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                child: GetBuilder<ParkingController>(builder: (_) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: PieChart(
                            dataMap: parkingController.getGraphMap(),
                            chartType: ChartType.ring,
                            chartRadius:
                                MediaQuery.of(context).size.width * 0.25,
                            ringStrokeWidth:
                                MediaQuery.of(context).size.width * 0.08,
                            colorList: [
                              themeController.theme.primaryColor,
                              themeController.theme.highlightColor
                            ],
                            chartValuesOptions: ChartValuesOptions(
                              showChartValues: false,
                            ),
                            legendOptions: LegendOptions(showLegends: false)),
                      ),
                      Text(
                        '${(parkingController.parking!.occupied! / parkingController.parking!.capacity! * 100).toInt()}%',
                        style: TextStyle(
                            color: themeController.theme.primaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: GetBuilder<ParkingController>(builder: (_) {
                  return Text(
                    'تعداد پارکینگ های آزاد: ${parkingController.parking!.capacity! - parkingController.parking!.occupied!} از ${parkingController.parking!.capacity} ',
                    style: TextStyle(color: themeController.theme.primaryColor),
                  );
                }),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      //top: MediaQuery.of(context).size.height * 0.445,
                      top: MediaQuery.of(context).size.height * 0.12,
                      bottom: 20),
                  child: PrimaryButton(
                    onTap: () {
                      Get.to(AddCarPage());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                            margin: EdgeInsets.only(right: 10),
                            child:
                                SvgPicture.asset('assets/parking_white.svg')),
                        Text(
                          'ورود خودرو',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: PrimaryButton(
                  onTap: () {
                    Get.to(ExitCarPage());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          margin: EdgeInsets.only(right: 10),
                          child: SvgPicture.asset('assets/exit_white.svg')),
                      Text(
                        'خروج خودرو',
                        textAlign: TextAlign.center,
                      ),
                    ],
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
