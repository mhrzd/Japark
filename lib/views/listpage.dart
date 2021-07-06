import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japark/controllers/parkingcontroller.dart';
import 'package:japark/controllers/themecontroller.dart';

import 'components/customappbar.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ThemeController themeController = ThemeController();

  ParkingController parkingController = Get.find();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkingController.getAllParkingCars().then((value) {
      isLoading = false;
      parkingController.cars.sort((a, b) => a.exited!.compareTo(b.exited!));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        action: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: FittedBox(
                  child: Icon(
                    Icons.view_list_rounded,
                    color: themeController.theme.primaryColor,
                  ),
                ))),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Get.back(),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  child: SvgPicture.asset('assets/back.svg'))),
        ),
        child: Text(
          'لیست خودرو ها',
          style: TextStyle(
              color: themeController.theme.primaryColor,
              fontFamily: 'IranSans',
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      backgroundColor: themeController.theme.canvasColor,
      body: SafeArea(
        child: Column(
          children: [
            GetBuilder<ParkingController>(
              builder: (_) {
                return isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 30),
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: parkingController.cars.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        parkingController.cars[i].phoneNumber!,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: parkingController
                                                        .cars[i].exited ==
                                                    1
                                                ? Colors.black26
                                                : Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        parkingController.cars[i].parkFloor!.toString(),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: parkingController
                                                        .cars[i].exited ==
                                                    1
                                                ? Colors.black26
                                                : Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            parkingController
                                                    .cars[i].plateNumber!
                                                    .substring(3, 6) +
                                                parkingController
                                                    .cars[i].plateNumber!
                                                    .substring(2, 3) +
                                                parkingController
                                                    .cars[i].plateNumber!
                                                    .substring(0, 2),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: parkingController
                                                            .cars[i].exited ==
                                                        1
                                                    ? Colors.black26
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            parkingController
                                                    .cars[i].plateNumber!
                                                    .substring(6) +
                                                '-',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: parkingController
                                                            .cars[i].exited ==
                                                        1
                                                    ? Colors.black26
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
