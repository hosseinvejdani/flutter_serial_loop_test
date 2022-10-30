import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/port_selector_widget.dart';
import '../../src/controller/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final testStyle = GoogleFonts.rajdhani(
      fontSize: 20.sp,
      color: Colors.green[300],
      letterSpacing: 1.1,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[850],
      body: Obx(
        () => SizedBox(
          width: 1.0.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PortSelectorWidget(),
              SizedBox(height: 50.h),
              ElevatedButton.icon(
                onPressed: () {
                  controller.rwTest();
                },
                icon: const Icon(Icons.swap_calls),
                label: const Text('Test Data'),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20.r), backgroundColor: Colors.green[400]),
              ),
              SizedBox(height: 50.h),
              controller.writedBytes.value.isEmpty ? Text('') : Text('WritedBytes: ${controller.writedBytes}', style: testStyle),
              SizedBox(height: 10.h),
              controller.readedBytes.value.isEmpty ? Text('') : Text('ReadedBytes: ${controller.readedBytes}', style: testStyle),
            ],
          ),
        ),
      ),
    );
  }
}
