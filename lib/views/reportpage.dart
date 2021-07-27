import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';

import 'package:japark/views/components/customappbar.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ThemeController themeController = ThemeController();

  ParkingController parkingController = Get.find();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    parkingController.getLastMonthProfit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        action: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: SvgPicture.asset('assets/graph_purple.svg'))),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Get.back(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  child: SvgPicture.asset('assets/back.svg'))),
        ),
        child: Text(
          'گزارش ماهانه',
          style: TextStyle(
              color: themeController.theme.primaryColor,
              fontFamily: 'IranSans',
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      backgroundColor: themeController.theme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                child: Wrap(
                  children: [
                    GetBuilder<ParkingController>(builder: (_) {
                      return Text(
                        'در یک ماه گذشته ${parkingController.getLastMonthCarsCount()} خودرو از پارکینگ ما استفاده کردند که باعث سوددهی ${parkingController.profit} تومانی پارکینگ شد' '\n' 'بیشترین مبلغ دریافتی ${parkingController.max} تومان و کمترین مبلغ دریافتی ${parkingController.min} تومان بوده است',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: themeController.theme.primaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
