import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading_widget.dart';
import '../controller/controller.dart';

class PortSelectorWidget extends StatelessWidget {
  PortSelectorWidget({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'SELECT PORT : ',
            style: GoogleFonts.rajdhani(
              fontSize: 20.sp,
              color: Colors.green[300],
              letterSpacing: 1.1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        const PortSelectorDropDownListWidget(),
        SizedBox(width: 30.w),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => controller.refreshPortList(),
          icon: Icon(
            Icons.autorenew_rounded,
            color: Colors.grey[100],
            size: 32.sp,
          ),
        )
      ],
    );
  }
}

class PortSelectorDropDownListWidget extends StatelessWidget {
  const PortSelectorDropDownListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    //
    return Center(
      child: Obx(
        () {
          var port = appController.selectedPortAddress.value;
          return port == 0
              ? const LoadingWidget(message: 'Please Wait ...')
              : DropdownButton<dynamic>(
                  value: port,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.green[200],
                  ),
                  elevation: 16,
                  dropdownColor: Colors.green[400],
                  style: TextStyle(color: Colors.grey[100]),
                  underline: Container(
                    height: 2.r,
                    color: Colors.green[300],
                  ),
                  onChanged: (dynamic value) {
                    appController.selectPort(selectedPort: value);
                  },
                  items: appController.availablePortsAddresses.map<DropdownMenuItem<dynamic>>(
                    (dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          padding: EdgeInsets.all(3.0.h),
                          width: min(160, 150.w),
                          height: min(100, 100.h),
                          child: Center(
                            child: Text(
                              "${SerialPort(value).name}",
                              maxLines: 1,
                              style: GoogleFonts.rajdhani(
                                fontSize: min(20, 20.sp),
                                color: Colors.white,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
        },
      ),
    );
  }
}
